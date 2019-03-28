class AddProviderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :encrypted_password, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    add_column :users, :confirmation_token, :string

    add_column :users, :sign_in_count, :integer
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet
  end
end
