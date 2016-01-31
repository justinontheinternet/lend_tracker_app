class User < ActiveRecord::Base

  has_many :items, dependent: :destroy
  has_many :loans, dependent: :destroy

  validates :user_name, presence: true,
    length: { maximum: 20 },
    uniqueness: true
  validates :password, presence: true,
    length: { maximum: 15 }
    
end