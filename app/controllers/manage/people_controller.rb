module Manage
  class PeopleController < ApplicationController
    before_action :logged_in?
    before_action lambda {
      permission?('manage_person_read')
    }

    def index
      @people = Person.all.order('house_id')
    end

    def show
      @person = Person.find(params[:id])
    end

    def edit
      @person = Person.find(params[:id])
    end

    def update
      @person = Person.find(params[:id])

      if @person.update(person_params)
        flash[:success] = 'Person saved'

        redirect_to manage_person_path @person.id
      else
        render 'edit'
      end
    end

    def residents
      @person = Person.find(params[:id])
      @residents = Person.where(street_number: @person.street_number)
    end

    def verify_account
      @person = Person.find(params[:id])

      @person.verified_at = DateTime.now
      @person.save

      redirect_to manage_person_path @person.id
    end

    def toggle_permission
      permission = params[:permission]
      person = Person.find params[:id]

      person_permission = PersonPermission.find_by person: person, permission: permission

      unless person_permission.nil?
        # revoke permission
        person_permission.destroy
        person_permission.save

        return redirect_to manage_person_path person.id
      end

      person_permission = PersonPermission.new
      person_permission.person = person
      person_permission.permission = permission
      person_permission.save

      if permission.include?('_write')
        new_permission = permission.sub! '_write', '_read'

        write_person_permission = PersonPermission.find_by person: person, permission: new_permission

        if write_person_permission.nil?
          # add read permission if given write
          write_person_permission = PersonPermission.new
          write_person_permission.person = person
          write_person_permission.permission = new_permission
          write_person_permission.save
        end
      end

      redirect_to manage_person_path person.id
    end

    private

    def person_params
      params.require(:person).permit(:first_name, :last_name, :email, :phone)
    end
  end
end
