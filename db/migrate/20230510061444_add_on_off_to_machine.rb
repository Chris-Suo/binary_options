class AddOnOffToMachine < ActiveRecord::Migration[7.0]
  def change
    add_column :machines, :on_off, :boolean, default: true
  end
end
