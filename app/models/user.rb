class User < ApplicationRecord
  before_destroy :admin_destroy_judge
  before_update :admin_update_judge
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }

  private

  def admin_destroy_judge
    if User.where(admin:true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end

  def admin_update_judge
    if User.find(id).admin
    throw(:abort) if (User.where(admin:true).count - [self].count == 0)
    end
  end
end
