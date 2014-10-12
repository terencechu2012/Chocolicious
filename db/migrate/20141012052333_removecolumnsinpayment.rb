class Removecolumnsinpayment < ActiveRecord::Migration
  def change
    remove_column :payments, :receiptname
    remove_column :payments, :receipttype
    remove_column :payments, :receiptsize
    remove_column :payments, :receiptupdatedat
  end
end
