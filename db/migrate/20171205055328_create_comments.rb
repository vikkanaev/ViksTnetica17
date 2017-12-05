class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :message
      t.string :commentable_type
      t.references :user, foreign_key: true
      t.references :commentable, polymorphic: true

      t.index [:commentable_id, :commentable_type], unique: true

      t.timestamps
    end
  end
end
