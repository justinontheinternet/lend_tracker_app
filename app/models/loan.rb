class Loan < ActiveRecord::Base
  
  belongs_to :item
  belongs_to :user

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :checkout, presence: true
  validate :valid_checkout?
  validate :valid_borrow_period?

  def valid_checkout?
    if checkout && checkout < Date.today
      errors.add(:pickup, "can't be earlier than today")
    end
  end

  def valid_borrow_period?
    if checkin && checkout > checkin
      errors.add(:return, "can't be earlier than pickup")
    else
      true
    end
  end

end