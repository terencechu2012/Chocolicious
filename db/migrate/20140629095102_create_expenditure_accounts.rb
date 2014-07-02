class CreateExpenditureAccounts < ActiveRecord::Migration
  def change
    create_table :expenditure_accounts do |t|
      t.string :clubid
      t.decimal :Category1Balance, precision: 10, scale: 2
      t.decimal :CategoryBalance, precision: 10, scale: 2
      t.decimal :Category3Balance, precision: 10, scale: 2
      t.decimal :Category4Balance, precision: 10, scale: 2
      t.decimal :Category5Balance, precision: 10, scale: 2
      t.decimal :Category6Balance, precision: 10, scale: 2
      t.decimal :Category7Balance, precision: 10, scale: 2
      t.decimal :Category8Balance, precision: 10, scale: 2
      t.decimal :Category9Balance, precision: 10, scale: 2
      t.decimal :Category10Balance, precision: 10, scale: 2
      t.decimal :Category11Balance, precision: 10, scale: 2
      t.decimal :Category12Balance, precision: 10, scale: 2
      t.decimal :Category13Balance, precision: 10, scale: 2
      t.decimal :MiscellaneousBalance, precision: 10, scale: 2

      t.timestamps
    end
  end
end
