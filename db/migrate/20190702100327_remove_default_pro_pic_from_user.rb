class RemoveDefaultProPicFromUser < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :pro_pic_url, "")
  end
end
