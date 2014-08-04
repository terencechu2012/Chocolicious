class ChangeYearBudgetToString < ActiveRecord::Migration
  def change
    change_column :budgets, :year, :string
  end
end
