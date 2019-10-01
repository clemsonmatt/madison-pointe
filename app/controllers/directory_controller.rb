class DirectoryController < ApplicationController
  before_action :logged_in?

  def index
    @all_officers = Person.where.not(officer_position: nil).order(officer_position: :asc)

    @temp_president = Person.new(
      first_name: 'Wade',
      last_name: 'Watt',
      officer_position: 'President'
    )

    @officers = []
    @officers.push(@temp_president)

    @all_officers.each do |officer|
      @officers.push(officer)
    end

    @people = Person.where(active: true).where.not(verified_at: nil).order(house_id: :asc)

    @all_people = {}

    @people.each do |person|
      @all_people[person.house] = [] unless @all_people.key?(person.house)
      @all_people[person.house].push(person)
    end
  end
end
