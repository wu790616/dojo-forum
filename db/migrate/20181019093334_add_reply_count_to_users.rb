class AddReplyCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :replies_count, :datetime
  end
end
