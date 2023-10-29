class AddBetToTrials < ActiveRecord::Migration[7.0]
  def change
    add_column :trials, :bet, :integer, null: false, default: 10
  end
end
