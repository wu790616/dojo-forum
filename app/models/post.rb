class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  scope :published, -> { where( draft: false ) }
  scope :draft, -> { where( draft: true ) }
  scope :open, -> { published.where(permission: "all") }
  scope :for_friend, -> { published.where(permission: "friend") }

  # 一個Post屬於一個使用者
  belongs_to :user

  # 一個Post有多個Categories
  has_many :tagships, dependent: :destroy
  has_many :categories, through: :tagships

  # 一個Post可有多篇reply
  has_many :replies, dependent: :destroy

  # 一個Post可被多個user collect
  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  
  def last_reply_filter
    unless self.last_reply
      return "N/A"
    else
      return self.last_reply.localtime.to_s(:long)
    end
  end

  def is_collected?(user)
    self.collected_users.include?(user)
  end

end
