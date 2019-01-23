class Manage::PeopleController < ApplicationController
  before_action :logged_in?

  def index
    @people = Person.all.order('street_number')
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

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :email, :phone)
  end
end
