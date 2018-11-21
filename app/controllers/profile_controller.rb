class ProfileController < ApplicationController
    before_action :logged_in?

    def index
    end

    def new
        @person = Person.new
    end

    def create
        @person = Person.new(person_params)
        @person.street_number = @user.street_number
        # @person.manually_added = true

        if @person.save
            flash[:success] = 'Person added'
            redirect_to profile_residents_path
        else
            render 'new'
        end
    end

    def edit
        @person = Person.find(params[:id])
    end

    def update
        @person = Person.find(params[:id])

        if @person.update(person_params)
            flash[:success] = 'Person saved'

            redirect_to profile_index_path
        else
            render 'edit'
        end
    end

    def residents
        @people = Person.where(street_number: @user.street_number)
    end

    private
        def person_params
            params.require(:person).permit(:first_name, :last_name, :email, :phone)
        end
end
