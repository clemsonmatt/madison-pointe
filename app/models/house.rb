class House < ApplicationRecord
  has_many :people, :restrict_with_execption
  has_many :dues_houses, :restrict_with_execption
end
