class RenameColumnTypeInAssetsToFileType < ActiveRecord::Migration
 def change
  rename_column :assets, :type, :file_type
 end

end
