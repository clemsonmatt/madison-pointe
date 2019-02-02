class CreateHouses < ActiveRecord::Migration[5.1]
  def change
    create_table :houses do |t|
      t.integer :number
      t.string :street

      t.timestamps
    end

    change_table :dues_houses do |t|
      t.belongs_to :house
    end

    change_table :people do |t|
      t.belongs_to :house
    end
  end
end
