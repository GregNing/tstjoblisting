class AddAttachmentToResume < ActiveRecord::Migration[5.1]
  def change
    add_column :resumes, :attachment, :string
  end
end
