class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.references :author
      t.references :last_reply
      t.references :last_reply_author

      t.timestamps
    end
    add_index :topics, :author_id
    add_index :topics, :last_reply_id
    add_index :topics, :last_reply_author_id
  end
end
