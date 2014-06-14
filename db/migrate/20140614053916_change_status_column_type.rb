class ChangeStatusColumnType < ActiveRecord::Migration
  def change
    change_column :claims, :status, :integer
  end
end
