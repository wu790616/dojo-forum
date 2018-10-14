class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 一個使用者有多篇Posts
  has_many :posts, dependent: :destroy
  
  # 檢查是否為管理員
  def admin?
    self.role == "admin"
  end
end
