class AddEmailNotificationsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :emailNotifications, :boolean, default: true
  end
end
