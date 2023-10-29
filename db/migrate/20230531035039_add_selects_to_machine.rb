class AddSelectsToMachine < ActiveRecord::Migration[7.0]
  def change
    add_column :machines, :exam_options, :string, array: true, default: []
  end
end
