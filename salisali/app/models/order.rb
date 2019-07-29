class Order < ApplicationRecord
    belongs_to :goods_master
    belongs_to :user

    validates :amount, numericality: {
            only_integer: true, greater_than_or_equal_to: 0
          }

        
end
