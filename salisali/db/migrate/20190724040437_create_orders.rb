class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :goods_master_id
      t.integer :amount
      t.date :delivery_date

      t.timestamps
    end
  end
end
