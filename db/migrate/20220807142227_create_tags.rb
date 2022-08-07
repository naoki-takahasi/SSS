class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false #タグ名(普通酒/純米 etc.)#
      t.timestamps
    end
  end
end
