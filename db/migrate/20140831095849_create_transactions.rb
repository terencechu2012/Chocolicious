class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :clubid
      t.string :clubcode
      t.string :year
      t.integer :semester
      t.string :typeoftransaction
      t.decimal :amount, :precision => 10, :scale => 2
      t.integer :depositid
      t.integer :claimid
      t.string :event
      t.string :purpose

      t.timestamps
    end
  end
end
