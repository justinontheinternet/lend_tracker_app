class User < ActiveRecord::Base

  has_many :items

  validates :name, presence: true,
    length: { maximum: 20 }
    
end