class Stock < ApplicationRecord
    belongs_to :goods_master
    has_many :orders
    
end
