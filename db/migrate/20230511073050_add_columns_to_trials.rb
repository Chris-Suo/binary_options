class AddColumnsToTrials < ActiveRecord::Migration[7.0]
  def change
    add_column :trials, :duplicated, :boolean, default: false
    add_column :trials, :evaluated, :boolean, default: false

    change_column_null :trials, :correctness, true
  end
end
