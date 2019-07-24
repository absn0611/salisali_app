class ChangeIdToGoodsMaster < ActiveRecord::Migration[5.2]
  def change
    change_column :goods_masters, :id, :string

  end
end
