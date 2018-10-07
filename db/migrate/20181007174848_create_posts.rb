class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.integer :views_count
      t.integer :replies_count
      t.boolean :draft
      t.string :image
      t.string :permission

      t.timestamps
    end
  end
end
