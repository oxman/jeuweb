class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.references :author
      t.references :topic

      t.timestamps
    end
    add_index :replies, :author_id
    add_index :replies, :topic_id
  end
end
