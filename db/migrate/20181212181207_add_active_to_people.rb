class AddActiveToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :active, :boolean, :null => false, :default => 0
  end
end
