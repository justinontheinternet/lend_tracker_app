class User < ActiveRecord::Base

  has_many :items

  validates :user_name, presence: true,
    length: { maximum: 20 }
    
end