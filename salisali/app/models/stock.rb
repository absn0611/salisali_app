class Stock < ApplicationRecord

    validates :goods_master_id, presence: true, uniqueness: true
    validates :quantity_of_stock, presence: true



    belongs_to :goods_master
    has_many :orders
    
end
