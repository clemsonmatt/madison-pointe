class DirectoryController < ApplicationController
  before_action :logged_in?

  def index
    @officers = Person.where.not(officer_position: nil)

    @people = Person.where(active: true).where.not(verified_at: nil)

    @all_people = {}

    @people.each do |person|
      @all_people[person.house] = [] unless @all_people.key?(person.house)
      @all_people[person.house].push(person)
    end
  end
end
