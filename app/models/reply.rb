class Reply < ApplicationRecord
  belongs_to :user, :counter_cache => true
  belongs_to :post, :counter_cache => true

  after_save :set_last_reply

  private

  def set_last_reply
    @post = self.post
    @post.last_reply = self.updated_at
    @post.save!
  end
end
