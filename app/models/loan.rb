class Loan < ActiveRecord::Base
  belongs_to :item

  validates :user_id,
  presence: true,
  validates :item_id,
  presence: true,
  validates :checkout,
  presence: true
end