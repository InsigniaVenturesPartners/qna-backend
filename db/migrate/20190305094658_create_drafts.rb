class CreateDrafts < ActiveRecord::Migration[5.1]
  def change
    create_table :drafts do |t|
      t.text :body
      t.integer :question_id
      t.integer :author_id

      t.timestamps
    end
  end
end
