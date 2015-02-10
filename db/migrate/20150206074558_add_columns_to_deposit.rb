class AddColumnsToDeposit < ActiveRecord::Migration
  def change
    add_column :deposits, :deposittype, :string
    add_column :deposits,:approvedby, :string
  end
end
