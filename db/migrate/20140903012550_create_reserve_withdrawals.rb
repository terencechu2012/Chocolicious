class CreateReserveWithdrawals < ActiveRecord::Migration
  def change
    create_table :reserve_withdrawals do |t|
      t.string :userid
      t.string :clubid
      t.decimal :amount, :precision => 10, :scale => 2
      t.string :purpose
      t.string :remarks
      t.integer :status

      t.timestamps
    end
  end
end
