class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :answer_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
