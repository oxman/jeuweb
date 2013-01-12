class AddLastActivityDateToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_activity_at, :datetime
  end
end
