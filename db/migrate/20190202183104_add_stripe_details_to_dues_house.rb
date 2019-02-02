class AddStripeDetailsToDuesHouse < ActiveRecord::Migration[5.1]
  def change
    add_column :dues_houses, :stripe_details, :text
  end
end
