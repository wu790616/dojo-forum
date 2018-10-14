class Category < ApplicationRecord
  # Category可被多個Post tag，當有Post關聯時，Category不可刪除
  has_many :tagships, dependent: :restrict_with_error
  has_many :posts, through: :tagships
end
