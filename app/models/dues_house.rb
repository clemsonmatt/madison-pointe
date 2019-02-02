class DuesHouse < ApplicationRecord
  belongs_to :due
  belongs_to :house
end
