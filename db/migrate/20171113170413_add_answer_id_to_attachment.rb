class AddAnswerIdToAttachment < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :answer_id, :integer
    add_index :attachments, :answer_id 
  end
end
