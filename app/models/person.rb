class Person < ApplicationRecord
  before_save :normalize_blank_values

  belongs_to :house
  has_many :person_permissions

  has_secure_password validations: false

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, allow_nil: true
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 8 },
                       on: :create
  validates :password, confirmation: true,
                       length: { minimum: 8 },
                       allow_blank: true,
                       on: :update

  def to_s
    "#{first_name} #{last_name}"
  end

  def normalize_blank_values
    %i[phone email].each do |column|
      self[column].present? || self[column] = nil
    end
  end

  def is_active(is_login = false)
    return active && email_verified_at if is_login

    return active && verified_at if email.nil?

    active && email_verified_at && verified_at
  end

  def permission?(permission)
    person_permissions.each do |person_permission|
      return true if person_permission.permission == permission
    end

    false
  end

  def valid_permissions
    [
      {
        key: 'manage_person_read',
        name: 'Manage person (Read only)'
      },
      {
        key: 'manage_person_write',
        name: 'Manage person (Write)'
      },
      {
        key: 'manage_dues',
        name: 'Manage dues'
      }
    ]
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
    return "$#{format('%0.02f', amount_due_for_year(year).amount)} due" unless paid_yearly_dues?(year)

    "#{year} dues paid"
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
