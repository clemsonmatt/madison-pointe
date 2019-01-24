class DirectoryController < ApplicationController
  before_action :logged_in?

  def index
    @people = Person.where.not(officer_position: nil)
  end

  def all
    @people = Person.where(active: true).where.not(verified_at: nil)

    @all_people = {}

    @people.each do |person|
      unless @all_people.key?(person.street_address)
        @all_people[person.street_address] = []
      end

      @all_people[person.street_address].push(
        'name' => person.to_s,
        'email' => person.email,
        'phone' => person.phone
      )
    end
  end
end
