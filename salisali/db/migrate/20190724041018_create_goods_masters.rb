class CreateGoodsMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :goods_masters do |t|
      t.string :goods_name
      t.integer :price
      t.text :about

      t.timestamps
    end
  end
end
