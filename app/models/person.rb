class Person < ApplicationRecord
  belongs_to :house

  def to_s
    "#{first_name} #{last_name}"
  end

  def is_active(is_login = false)
    return active && email_verified_at if is_login

    return active && verified_at if email.nil?

    active && email_verified_at && verified_at
  end

  def amount_due_for_year(year)
    Due.find_by year: year
  end

  def amount_due_for_year_stripe(year)
    due = amount_due_for_year(year)

    (due.amount * 100).to_i
  end

  def paid_yearly_dues?(year)
    dues = DuesHouse.find_by due: amount_due_for_year(year), house: house

    dues.paid
  end

  def dues_for_year(year)
    return "$#{format('%0.02f', amount_due_for_year(year).amount)} owed" unless paid_yearly_dues?(year)

    "#{year} dues paid"
  end

  has_secure_password validations: false

  validates :first_name, presence: true
  validates :last_name, presence: true
end
