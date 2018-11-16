class AddStreetNumberToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :street_number, :int
  end
end
