class RenameTrailBet < ActiveRecord::Migration[7.0]
  def change
    rename_column :trials, :bet, :exam_option
  end
end
