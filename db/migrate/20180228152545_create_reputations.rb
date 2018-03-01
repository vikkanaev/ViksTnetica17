class CreateReputations < ActiveRecord::Migration[5.0]
  def change
    create_table :reputations do |t|

      t.timestamps
    end
  end
end
