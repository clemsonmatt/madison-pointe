module Manage
  class DuesController < ApplicationController
    before_action :logged_in?
    before_action lambda {
      permission?('manage_dues')
    }

    def index
      @year = current_year
      @dues = Manage::DuesHelper.find_or_create_dues(@year)
      @house_dues = Manage::DuesHelper.find_or_create_house_dues(@dues)
    end

    def dues_by_year
      @year = params[:year]
      @dues = Manage::DuesHelper.find_or_create_dues(@year)
      @house_dues = Manage::DuesHelper.find_or_create_house_dues(@dues)

      render :index
    end

    def update
      @due = Due.find params[:id]

      if @due.update(amount: params[:due][:amount])
        flash[:success] = 'Amount saved'
      else
        flash[:danger] = 'Amount not saved'
      end

      redirect_to manage_dues_path
    end

    def dues_paid
      house = House.find params[:id]
      year_due = Due.find_by year: params[:year]

      @dues_house = DuesHouse.find_by due: year_due, house: house
      @dues_house.paid = true
      @dues_house.date = DateTime.current
      @dues_house.save!

      flash[:success] = "#{house} marked as paid"

      redirect_to manage_dues_by_year_path(params[:year])
    end

    def dues_not_paid
      house = House.find params[:id]
      year_due = Due.find_by year: params[:year]

      @dues_house = DuesHouse.find_by due: year_due, house: house
      @dues_house.paid = false
      @dues_house.date = nil
      @dues_house.save!

      flash[:info] = "#{house} marked as not paid"

      redirect_to manage_dues_by_year_path(params[:year])
    end

    def reminder_notification
      due = Due.find_by(year: current_year)
      house_dues = DuesHouse.where(due: due, paid: false)

      house_dues.each do |dues_house|
        addresses = []

        dues_house.house&.people.each do |person|
          addresses.push(person.email) if person.notify_dues? && person.is_active
        end

        next if addresses.empty?

        DuesMailer.with(dues_house: dues_house, addresses: addresses).dues_reminder.deliver_now
      end

      flash[:info] = 'Reminder notification sent'

      redirect_to manage_dues_by_year_path(current_year)
    end

    private

    def current_year
      Due.last.year
    end
  end
end
