class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :sake_id, foreign_key: true #商品ID(商品参照用)#
      t.integer :shop_id, foreign_key: true #販売会員ID(販売店参照用)#
      t.text    :comment, null: false #コメント#
      t.timestamps
    end
  end
end
