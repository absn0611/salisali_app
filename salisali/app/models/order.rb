class Order < ApplicationRecord

  validates :user_id, presence: true
  validates :goods_master_id, presence: true
  validates :amount, presence: true
  validates :delivery_date, presence: true
  validates :status, presence: true





  validates :amount, numericality: {
    only_integer: true, greater_than_or_equal_to: 1
  }


    belongs_to :goods_master
    belongs_to :user

end
