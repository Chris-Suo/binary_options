class AddCustomOptionToMachine < ActiveRecord::Migration[7.0]
  def change
    add_column :machines, :custom_option, :integer, null: false, default: 100
  end
end
