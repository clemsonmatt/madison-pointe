class CreateDuesHouses < ActiveRecord::Migration[5.1]
  def change
    create_table :dues_houses do |t|
      t.integer :street_number
      t.boolean :paid, default: false, null: false
      t.datetime :date

      t.timestamps
    end

    change_table :dues_houses do |t|
      t.belongs_to :due
    end
  end
end
