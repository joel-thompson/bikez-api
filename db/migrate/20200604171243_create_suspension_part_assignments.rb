class CreateSuspensionPartAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :suspension_part_assignments do |t|
      t.references :bike, null: false, foreign_key: true
      t.references :suspension_part, null: false, foreign_key: true
      t.datetime :assigned_at, null: false
      t.datetime :removed_at

      t.timestamps
    end
  end
end
