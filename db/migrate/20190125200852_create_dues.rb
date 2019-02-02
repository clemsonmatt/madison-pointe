class CreateDues < ActiveRecord::Migration[5.1]
  def change
    create_table :dues do |t|
      t.string :year
      t.float :amount
      t.datetime :notified_at

      t.timestamps
    end
  end
end
