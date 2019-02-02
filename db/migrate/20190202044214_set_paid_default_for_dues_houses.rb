class SetPaidDefaultForDuesHouses < ActiveRecord::Migration[5.1]
  def change
    change_column :dues_houses, :paid, :boolean, default: false, nullify: false
  end
end
