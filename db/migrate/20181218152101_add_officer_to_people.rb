class AddOfficerToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :officer_position, :string
  end
end
