class AddScoreToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :score, :integer, default: 0, null: false
  end
end
