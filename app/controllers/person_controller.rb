class PersonController < ApplicationController
    before_action :logged_in?

    def index
        @people = Person.all.order(last_name: :asc)
    end

    def show
        @person = Person.find(params[:id])
    end

    def new
        @person = Person.new
    end

    def create
        @person = Person.new(person_params)

        if @person.save
            flash[:success] = 'Person added'
            redirect_to person_path(@person)
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
            redirect_to person_path(@person)
        else
            render 'edit'
        end
    end

    def destroy
    end

    private
        def person_params
            params.require(:person).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :permissions => [])
        end
end
