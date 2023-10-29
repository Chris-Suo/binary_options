class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |t|

      t.references :machine, null: false, foreign_key: true
      t.datetime :batch_at
      t.integer :batch_at_code
      t.integer :answer_code
      t.string :answer_string

      t.timestamps
    end
  end
end
