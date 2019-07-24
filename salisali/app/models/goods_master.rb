class GoodsMaster < ApplicationRecord
    has_one :stock
    has_many :orders
end
