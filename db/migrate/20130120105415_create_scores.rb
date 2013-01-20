class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :scorable_type
      t.integer :scorable_id
      t.references :user
      t.integer :value

      t.timestamps
    end
    add_index :scores, :user_id
    add_index :scores, [ :scorable_type, :scorable_id ]
    add_index :scores, [ :scorable_type, :scorable_id, :user_id ], unique: true
  end
end
