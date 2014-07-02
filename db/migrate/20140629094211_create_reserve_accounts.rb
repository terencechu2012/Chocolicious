class CreateReserveAccounts < ActiveRecord::Migration
  def change
    create_table :reserve_accounts do |t|
      t.string :clubid
      t.decimal :balance, precision: 10, scale: 2
      t.decimal :limit, precision: 10, scale: 2

      t.timestamps
    end
  end
end
