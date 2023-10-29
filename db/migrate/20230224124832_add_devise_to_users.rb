# frozen_string_literal: true

# shit
class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  # shit
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string(:username, null: false, comment: "使用者名稱")
      t.string(:encrypted_password, null: false, comment: "加密密碼")

      # basic info
      t.integer(:quota, null: false, default: 0, comment: "元件")
      t.integer(:level, null: false, default: 0, comment: "身份等級群組")
      t.boolean(:active, null: false, default: true, comment: "是否使用中")
      t.integer(:created_by, comment: "紀錄是哪位使用者創立的帳號")

      ## Rememberable
      t.datetime(:remember_created_at)

      ## Trackable
      t.integer(:sign_in_count, default: 0, null: false)
      t.datetime(:current_sign_in_at)
      t.datetime(:last_sign_in_at)
      t.string(:current_sign_in_ip)
      t.string(:last_sign_in_ip)

      t.timestamps null: false
    end

    add_index(:users, :username, unique: true)
    # add_index :users, :email,                unique: true
    # add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
