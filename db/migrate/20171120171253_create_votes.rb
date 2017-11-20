class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :score, default: 0
      t.references :user, foreign_key: true
      t.references :votable, polymorphic: true
      t.index [:user_id, :votable_id, :votable_type], unique: true

      t.timestamps
    end
  end
end
