class DirectoryController < ApplicationController
    def index
        # @people = Person.where(active: true).where.not(verified_at: nil)
        @people = Person.where(active: true)

        @all_people = {}

        @people.each do |person|
            if ! @all_people.key?(person.street_address)
                @all_people[person.street_address] = []
            end

            @all_people[person.street_address].push({
                'name' => person.to_s,
                'email' => person.email,
                'phone' => person.phone,
            })
        end
    end
end
