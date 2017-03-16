class AddPreferredNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :preferred_name, :string
  end
end
