class AddCountDefaultToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :views_count, :integer, default: 0
    change_column :posts, :replies_count, :integer, default: 0
  end
end
