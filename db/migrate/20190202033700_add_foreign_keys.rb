class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :people, :houses
    add_foreign_key :dues_houses, :houses
    add_foreign_key :dues_houses, :dues
  end
end
