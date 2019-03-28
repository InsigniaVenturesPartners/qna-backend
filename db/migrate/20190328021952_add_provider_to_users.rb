class AddProviderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :encrypted_password, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    add_column :users, :confirmation_token, :string
  end
end
