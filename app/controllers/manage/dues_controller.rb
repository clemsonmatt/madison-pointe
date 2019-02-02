module Manage
  class DuesController < ApplicationController
    def index
      @year = current_year
      @dues = Manage::DuesHelper.find_or_create_dues(@year)
      @house_dues = Manage::DuesHelper.find_or_create_house_dues(@dues)
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
      year_due = Due.find_by year: current_year

      @dues_house = DuesHouse.find_by due: year_due, house: house
      @dues_house.paid = true
      @dues_house.date = DateTime.current
      @dues_house.save!

      flash[:success] = "#{house} marked as paid"

      redirect_to manage_dues_path
    end

    private

    def current_year
      Date.current.strftime('%Y')
    end
  end
end
