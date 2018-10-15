class AddPermissionDefaultToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :permission, :string, default: 'all'
  end
end
