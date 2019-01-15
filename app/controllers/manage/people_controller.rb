class Manage::PeopleController < ApplicationController
    before_action :logged_in?

    def index
        @people = Person.all.order('street_number')
    end
end
