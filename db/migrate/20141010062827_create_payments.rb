class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :userid
      t.string :clubid
      t.decimal :amount, precision: 5, scale: 4
      t.integer :status
      t.string :category
      t.string :receiptname
      t.string :receipttype
      t.integer :receiptsize
      t.string :remark
      t.string :nric
      t.string :event
      t.string :expense

      t.timestamps
    end
  end
end
