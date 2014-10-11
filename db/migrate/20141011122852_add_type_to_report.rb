class AddTypeToReport < ActiveRecord::Migration
  def change
    add_column :allocation_reports, :type, :string
  end
end
