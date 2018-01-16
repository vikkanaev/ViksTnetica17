class AddConfirmableToAuthorization < ActiveRecord::Migration[5.0]
  def change
    add_column :authorizations, :confirmation_token, :string
    add_column :authorizations, :unconfirmed_email, :string
    add_column :authorizations, :confirmed_at, :datetime
  end
end
