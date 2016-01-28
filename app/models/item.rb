class Item < ActiveRecord::Base

  belongs_to :user
  has_one :loan

  validates :user_id, presence: true
  validates :name, presence: true,
    length: { maximum: 25 }
    
end