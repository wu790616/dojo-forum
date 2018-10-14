class Post < ApplicationRecord
  # 一個Post屬於一個使用者
  belongs_to :user
end
