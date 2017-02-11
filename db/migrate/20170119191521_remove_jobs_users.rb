class RemoveJobsUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :jobs_users
  end
end
