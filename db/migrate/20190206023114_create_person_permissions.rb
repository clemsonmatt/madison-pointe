class CreatePersonPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :person_permissions do |t|
      t.references :person, foreign_key: true
      t.string :permission

      t.timestamps
    end
  end
end
