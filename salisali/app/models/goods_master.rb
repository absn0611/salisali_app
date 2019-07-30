class GoodsMaster < ApplicationRecord
    has_one :stock, :through => :orders
end
