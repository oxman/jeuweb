class AddTopicsCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :topics_count, :integer, null: false, default: 0
  end
end
