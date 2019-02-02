class RemoveStreetNumberFromPeople < ActiveRecord::Migration[5.1]
  def change
    remove_column :people, :street_number
    remove_column :dues_houses, :street_number
  end
end
