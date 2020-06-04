class SuspensionPartRenameTypeToComponentType < ActiveRecord::Migration[6.0]
  def change
    rename_column :suspension_parts, :type, :component_type
  end
end
