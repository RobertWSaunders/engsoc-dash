class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.timestamps
      t.string :title
      t.string :description
    end
  end
end
