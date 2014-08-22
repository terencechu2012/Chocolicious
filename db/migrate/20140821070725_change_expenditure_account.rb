class ChangeExpenditureAccount < ActiveRecord::Migration
  def change
    remove_column :expenditure_accounts, :Category3Balance
    remove_column :expenditure_accounts, :Category4Balance
    remove_column :expenditure_accounts, :Category5Balance
    remove_column :expenditure_accounts, :Category6Balance
    remove_column :expenditure_accounts, :Category7Balance
    remove_column :expenditure_accounts, :Category8Balance
    remove_column :expenditure_accounts, :Category9Balance
    remove_column :expenditure_accounts, :Category10Balance
    remove_column :expenditure_accounts, :Category11Balance
    remove_column :expenditure_accounts, :Category12Balance
    remove_column :expenditure_accounts, :Category13Balance
    remove_column :expenditure_accounts, :MiscellaneousBalance
  end
end
