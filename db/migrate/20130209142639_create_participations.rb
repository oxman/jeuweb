class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :topic
      t.references :user

      t.timestamps
    end
    add_index :participations, :topic_id
    add_index :participations, :user_id
  end
end
