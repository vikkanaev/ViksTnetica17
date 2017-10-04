class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :question_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
