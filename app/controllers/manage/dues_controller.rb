module Manage
  class DuesController < ApplicationController
    def index
      @year = Date.current.strftime('%Y')
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
  end
end
