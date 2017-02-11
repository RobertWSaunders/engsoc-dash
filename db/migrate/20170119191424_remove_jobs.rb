class RemoveJobs < ActiveRecord::Migration[5.0]
  def change
    drop_table :jobs
  end
end
