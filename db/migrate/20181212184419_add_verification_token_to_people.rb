class AddVerificationTokenToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :verification_token, :string
  end
end
