class AddGoogleIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :google_id, :string
    add_column :users, :given_name, :string
    add_column :users, :last_name, :string
    add_column :users, :access_token, :string

	remove_column :users, :confirmed_at, :datetime
	remove_column :users, :confirmation_sent_at, :datetime
	remove_column :users, :unconfirmed_email, :datetime
    remove_column :users, :confirmation_token, :string
    remove_column :users, :reset_password_token, :string
	remove_column :users, :reset_password_sent_at, :datetime
	remove_column :users, :remember_created_at, :datetime
	remove_column :users, :sign_in_count, :integer
	remove_column :users, :current_sign_in_at, :datetime
	remove_column :users, :last_sign_in_at, :datetime
	remove_column :users, :current_sign_in_ip, :inet
	remove_column :users, :last_sign_in_ip, :inet
	remove_column :users, :encrypted_password, :string
	remove_column :users, :provider, :string
	remove_column :users, :uid, :string

    add_index :users, :google_id, unique: true
  end
end
