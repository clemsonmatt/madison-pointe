class ChangePasswordToNull < ActiveRecord::Migration[5.1]
  def change
    change_column :people, :password_digest, :string, null: true
  end
end
