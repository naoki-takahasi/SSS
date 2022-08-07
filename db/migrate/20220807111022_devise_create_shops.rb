# frozen_string_literal: true

class DeviseCreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string  :name,         null: false #販売店の名称、屋号#
      t.string  :post,         null: false #郵便番号#
      t.text    :address,      null: false #住所#
      t.string  :tel,          null: false #電話番号#
      t.boolean :is_enable, default: true, null: false #開業/閉業(デフォルトは開業)#

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :shops, :email,                unique: true
    add_index :shops, :reset_password_token, unique: true
    # add_index :shops, :confirmation_token,   unique: true
    # add_index :shops, :unlock_token,         unique: true
  end
end
