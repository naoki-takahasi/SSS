class CreateSakes < ActiveRecord::Migration[6.1]
  def change
    create_table :sakes do |t|
      t.integer :brewery_id, foreign_key: true #酒造会員ID(製造元参照用)#
      t.integer :tag_id,     foreign_key: true #タグID(タグ参照用)#
      t.string  :name,       null: false #製品名#
      t.text    :explain,    null: false #製品説明#
      t.boolean :is_active,  default: true, null: false #販売/休売#
      t.integer :price,      null: false #税抜価格#
      t.timestamps
    end
  end
end
