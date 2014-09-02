class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :reserve_limits, :remarks, :text, :limit => 4294967295
  end
end
