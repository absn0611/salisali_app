class GoodsMaster < ApplicationRecord
    has_one :stock, dependent:  :destroy
end
