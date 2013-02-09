class AddPrivateFlagToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :private, :boolean, null: false, default: false
  end
end
