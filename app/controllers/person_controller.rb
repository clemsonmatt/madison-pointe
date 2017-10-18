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
            redirect_to person_index_path(@person)
        else
            render 'new'
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
        def person_params
            params.require(:person).permit(:first_name, :last_name, :email, :password, :password_confirmation, :permissions => [])
        end
end
