class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  # 一個Post屬於一個使用者
  belongs_to :user

  # 一個Post有多個Categories
  has_many :tagships, dependent: :destroy
  has_many :categories, through: :tagships

  # 一個Post可有多篇reply
  has_many :replies, dependent: :destroy

end
