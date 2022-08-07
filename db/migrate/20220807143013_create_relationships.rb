class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :brewery_id, foreign_key: true #酒造会員ID(酒造参照用)#
      t.integer :shop_id,    foreign_key: true #販売会員ID(販売店参照用)#
      t.timestamps
    end
  end
end
