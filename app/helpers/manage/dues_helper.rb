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
    end
  end
end
