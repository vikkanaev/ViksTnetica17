class RemoveQuestionIdFromQuestion < ActiveRecord::Migration[5.0]
  def change
    remove_column :questions, :question_id, :integer
  end
end
