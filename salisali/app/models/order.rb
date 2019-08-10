class Order < ApplicationRecord
  validates :amount, numericality: {
    only_integer: true, greater_than_or_equal_to: 1
  }


    belongs_to :goods_master
    belongs_to :user

end
