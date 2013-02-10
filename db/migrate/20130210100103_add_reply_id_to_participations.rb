class AddReplyIdToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :from_reply_id, :integer
  end
end
