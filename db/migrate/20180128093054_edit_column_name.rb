class EditColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :jobs, :users_id, :user_id
  end
end
