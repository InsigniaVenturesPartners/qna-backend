class AddPicUrlToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :pic_url, :string
  end
end
