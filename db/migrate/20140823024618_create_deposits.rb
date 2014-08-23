class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.string :userid
      t.string :clubid
      t.decimal :amount, :precision => 10, :scale => 2
      t.integer :status
      t.string :remarks
      t.date :date
      t.string :receipts
      t.string :donorname
      t.string :donoradd
      t.string :donoric
      t.string :purpose

      t.timestamps
    end
  end
end
