class AddForeignkeyToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :question_id, :integer
    add_foreign_key :answers, :questions
  end
end
