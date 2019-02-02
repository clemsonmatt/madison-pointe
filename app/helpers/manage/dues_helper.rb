module Manage
  module DuesHelper
    class << self
      def find_or_create_dues(year)
        dues = Due.find_by year: year

        return dues unless dues.nil?

        Due.create!(
          year: year,
          amount: 0.00
        )
      end

      def find_or_create_house_dues(due)
        dues_by_house = DuesHouse.where(due: due).order(paid: :asc).order(house_id: :asc)

        return dues_by_house unless dues_by_house.length.zero?

        House.all.each do |house|
          DuesHouse.create! house: house, due: due
        end

        DuesHouse.where due: due
      end
    end
  end
end
