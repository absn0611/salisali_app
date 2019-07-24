class ChangeIdToStock < ActiveRecord::Migration[5.2]
  def change
    change_column :stocks, :id, :string
    rename_column :stocks, :id, :goods_master_id
  end
end
