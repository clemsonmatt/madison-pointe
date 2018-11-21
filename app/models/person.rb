class Person < ApplicationRecord

    def to_s
        "#{self.first_name} #{self.last_name}"
    end

    has_secure_password validations: false

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :street_number, presence: true
end
