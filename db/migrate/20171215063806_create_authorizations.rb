class CreateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :authorizations do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.index [:provider, :uid]

      t.timestamps
    end
  end
end
