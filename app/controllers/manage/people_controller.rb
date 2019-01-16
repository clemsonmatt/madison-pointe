class Manage::PeopleController < ApplicationController
    before_action :logged_in?

    def index
        @people = Person.all.order('street_number')
    end

    def profile
        @person = Person.find(params[:id])
    end

    def verify_account
        @person = Person.find(params[:id])

        @person.verified_at = DateTime.now
        @person.save

        redirect_to manage_person_profile_path(@person.id)
    end
end
