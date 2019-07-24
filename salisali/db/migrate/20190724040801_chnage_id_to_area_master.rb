class ChnageIdToAreaMaster < ActiveRecord::Migration[5.2]
  def change
    change_column :area_masters, :id, :string
  end
end
