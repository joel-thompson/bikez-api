class CreateSuspensionParts < ActiveRecord::Migration[6.0]
  def change
    create_table :suspension_parts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :type, null: false
      t.boolean :high_speed_compression, null: false, default: false
      t.boolean :low_speed_compression, null: false, default: true
      t.boolean :high_speed_rebound, null: false, default: false
      t.boolean :low_speed_rebound, null: false, default: true
      t.boolean :volume, null: false, default: true
      t.boolean :pressure, null: false, default: true
      t.boolean :spring_rate, null: false, default: false

      t.timestamps
    end
  end
end
