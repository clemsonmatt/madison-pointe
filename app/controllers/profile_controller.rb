class ProfileController < ApplicationController
  before_action :logged_in?

  def index
    @year = Date.current.strftime('%Y')
    @stripe_api_key = ENV['STRIPE_API_KEY']
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.street_number = @user.street_number

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

  def resident_delete
    @person = Person.find(params[:id])

    if !@person.password_digest.nil? || @person.street_number != @user.street_number
      flash[:danger] = 'Permission denied'
    else
      flash[:info] = "Removed #{@person}"
      @person.destroy
    end

    redirect_to profile_residents_path
  end

  def pay_dues
    token = params[:stripeToken]
    year = Date.current.strftime('%Y')

    Stripe.api_key = ENV['STRIPE_API_SECRET_KEY']
    charge = Stripe::Charge.create(
      amount: @user.amount_due_for_year_stripe(year),
      currency: 'usd',
      description: "#{year} HOA Dues",
      source: token,
      receipt_email: @user.email
    )

    yearly_dues = Due.find_by year: year

    dues_house = DuesHouse.find_by due: yearly_dues, house: @user.house
    dues_house.stripe_details = charge
    dues_house.paid = true
    dues_house.date = DateTime.current
    dues_house.save!

    redirect_to profile_index_path
  end

  def update_settings
    setting = params[:setting]

    @user.send("#{setting}=", !@user.send(setting))
    @user.save!

    flash[:success] = 'Setting saved'

    redirect_to profile_index_path
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :email, :phone)
  end
end
