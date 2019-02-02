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

  has_secure_password validations: false

  validates :first_name, presence: true
  validates :last_name, presence: true
end
