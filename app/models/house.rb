class House < ApplicationRecord
  has_many :people
  has_many :dues_houses

  def to_s
    address
  end

  def address
    "#{number} #{street}"
  end
end
