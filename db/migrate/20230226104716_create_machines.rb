class CreateMachines < ActiveRecord::Migration[7.0]
  def change
    create_table :machines do |t|

      t.string :name
      t.string :description
      t.string :image_url
      t.string :slug

      t.string :option1
      t.string :option2
      t.string :option3
      t.string :option4

      t.timestamps
    end
  end
end
