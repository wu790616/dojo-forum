class AddEditTimeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :edit_time, :datetime
  end
end
