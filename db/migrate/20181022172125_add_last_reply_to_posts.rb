class AddLastReplyToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :last_reply, :datetime
  end
end
