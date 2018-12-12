class AddVerificationToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :email_verified_at, :datetime
    add_column :people, :verified_at, :datetime
  end
end
