class AddTrustFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trusted, :boolean, default: false, null: false
  end
end
