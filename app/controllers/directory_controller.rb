class DirectoryController < ApplicationController
  before_action :logged_in?

  def index
    @officers = Person.where.not(officer_position: nil).order(officer_position: :asc)

    @people = Person.where(active: true).where.not(verified_at: nil).order(house_id: :asc)

    @all_people = {}

    @people.each do |person|
      @all_people[person.house] = [] unless @all_people.key?(person.house)
      @all_people[person.house].push(person)
    end
  end
end
