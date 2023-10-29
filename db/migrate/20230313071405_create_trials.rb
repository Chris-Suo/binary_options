class CreateTrials < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :trials, id: :uuid do |t|
      t.references :user, foreign_key: true, null: false
      t.references :machine, foreign_key: true, null: false
      t.references :exam, foreign_key: true, null: false

      t.integer :answer, null: false
      t.boolean :correctness, null: false
      t.integer :batch_at_code, null: false

      t.integer :quota_before, null: false, default: 0
      t.integer :quota_after, null: false, default: 0
      t.integer :quota_change, null: false, default: 0

      t.timestamps
    end
  end
end
