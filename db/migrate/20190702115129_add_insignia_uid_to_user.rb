class AddInsigniaUidToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :insignia_uid, :string
    add_index :users, :insignia_uid
  end
end
