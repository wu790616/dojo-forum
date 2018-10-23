class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader
  validates_presence_of :name

  # 一個使用者有多篇Posts
  has_many :posts, dependent: :destroy

  # 一個使用者有多個Reply
  has_many :replies, dependent: :destroy
  has_many :replied_posts, through: :replies, source: :post

  # 一個使用者有多個Collect
  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: :post
  
  # 一個使用者有多個朋友邀請
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  # 檢查是否為管理員
  def admin?
    self.role == "admin"
  end
end
