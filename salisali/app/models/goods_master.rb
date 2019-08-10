class GoodsMaster < ApplicationRecord
    validates :id, presence: true, uniqueness: true
    validates :goods_name, presence: true, uniqueness: true
    validates :price, presence: true

    has_one :stock, dependent:  :destroy
end
