class AddCountDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :replies_count, :integer, default: 0
  end
end
