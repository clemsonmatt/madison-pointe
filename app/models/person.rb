class Person < ApplicationRecord

    def to_s
        "#{self.first_name} #{self.last_name}"
    end

    def is_active
        self.active && self.email_verified_at
    end

    def self.valid_street_numbers
        {
            'Madison Pointe Dr': [
                102,
                103,
                107,
                111,
                114,
                115,
                119,
                123,
                127,
                130,
                131,
                134,
                138,
                142,
                145,
                146,
                149,
                150,
                153,
                157,
                161,
                162,
                165,
                166,
                169,
                170,
                173,
                174,
                177,
                178,
            ],
            'Buchanana Trl' => [
                303,
                306,
                307,
                310,
                311,
                314,
                316
            ],
            'McKinley CT' => [
                405,
                406,
                410
            ],
            'Lincoln Terrace Dr' => [
                505,
                506,
                510
            ]

        }
    end

    has_secure_password validations: false

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :street_number, presence: true
end
