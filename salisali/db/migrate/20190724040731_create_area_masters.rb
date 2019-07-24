class CreateAreaMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :area_masters do |t|
      t.string :area_name
      t.integer :distance_from_store

      t.timestamps
    end
  end
end
