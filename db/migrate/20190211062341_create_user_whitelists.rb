class CreateUserWhitelists < ActiveRecord::Migration[5.1]
  def change
    create_table :user_whitelists do |t|
      t.string :email

      t.timestamps
    end
    add_index :user_whitelists, :email
  end
end
