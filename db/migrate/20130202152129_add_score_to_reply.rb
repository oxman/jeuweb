class AddScoreToReply < ActiveRecord::Migration
  def change
    add_column :replies, :score, :integer, null: false, default: 0
  end
end
