class AddUserToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs,:users_id, :integer
  end
end
