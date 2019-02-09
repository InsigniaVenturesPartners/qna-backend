class CreatePartnerAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_auths do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.text :auth_json

      t.timestamps
    end

    add_index :partner_auths, [:user_id, :provider], :unique => true
  end
end
