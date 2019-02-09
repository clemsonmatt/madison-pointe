class AddPrivacyColumnsToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :show_email, :bool, null: false, default: false
    add_column :people, :show_phone, :bool, null: false, default: false
    add_column :people, :notify_announcement, :bool, null: false, default: false
    add_column :people, :notify_dues, :bool, null: false, default: false
  end
end
