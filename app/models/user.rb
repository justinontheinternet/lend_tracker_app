class User < ActiveRecord::Base

  has_many :items
  has_many :loans

  validates :user_name, presence: true,
    length: { maximum: 20 }
    
end