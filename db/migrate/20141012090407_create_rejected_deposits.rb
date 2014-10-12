class CreateRejectedDeposits < ActiveRecord::Migration
  def change
    create_table :rejected_deposits do |t|
      t.integer :depositid
      t.string :clubid
      t.string :madeby
      t.string :rejectedby
      t.decimal :amount, precision: 10, scale: 2
      t.integer :status
      t.string :remarks

      t.timestamps
    end
  end
end
