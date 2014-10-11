class RenameColumnName < ActiveRecord::Migration
  def change
    rename_column :allocation_reports, :type, :reporttype
  end
end
