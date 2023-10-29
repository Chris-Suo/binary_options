class AddFinishedToMachines < ActiveRecord::Migration[7.0]
  def change
    add_column :machines, :finished, :boolean, default: false
  end
end
