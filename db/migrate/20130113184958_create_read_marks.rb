class CreateReadMarks < ActiveRecord::Migration
  def change
    create_table :read_marks do |t|
      t.references :user
      t.references :topic
      t.references :reply

      t.timestamps
    end
    add_index :read_marks, :user_id
    add_index :read_marks, :topic_id
    add_index :read_marks, :reply_id
  end
end
