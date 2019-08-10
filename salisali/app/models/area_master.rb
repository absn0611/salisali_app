class AreaMaster < ApplicationRecord
    validates :id, presence: true, uniqueness: true
    validates :area_name, presence: true, uniqueness: true
    validates :distance_from_store, presence: true

    has_many :users
    accepts_nested_attributes_for :users
end
