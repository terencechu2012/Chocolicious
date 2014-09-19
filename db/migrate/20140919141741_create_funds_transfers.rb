class CreateFundsTransfers < ActiveRecord::Migration
  def change
    create_table :funds_transfers do |t|
      t.string :userid
      t.string :clubidfrom
      t.string :clubidto
      t.decimal :amount, precision: 10, scale: 2
      t.string :remarks
      t.integer :status
      t.string :purpose
      t.timestamps
    end
  end
end
