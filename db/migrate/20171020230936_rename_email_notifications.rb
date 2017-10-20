class Renameemail_notifications < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :email_notifications, :email_notifications
  end
end
