class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :disallow_self

  def accept
    user.friends << friend
    destroy
  end

  # 自訂驗證
  def disallow_self
    if user_id == friend_id
      errors[:friend_id] << 'cannot add self as friend'
    end
  end
end
