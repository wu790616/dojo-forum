class AddDraftDefaultToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :draft, :boolean, default: true
  end
end
