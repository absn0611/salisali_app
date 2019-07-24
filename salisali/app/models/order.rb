class Order < ApplicationRecord
    belongs_to :goods_master
    belongs_to :user
end
