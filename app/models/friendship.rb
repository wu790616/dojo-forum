class Friendship < ApplicationRecord
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  after_create :create_inverse_relationship
  
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def create_inverse_relationship
    friend.friendships.create(friend: user)
  end
end
