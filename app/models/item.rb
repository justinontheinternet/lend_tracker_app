class Item < ActiveRecord::Base

  validates :user_id, presence: true
  validates :name, presence: true,
    length: { maximum: 25 }
    
end