class AddForeignkeyToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :answers, :questions
  end
end
