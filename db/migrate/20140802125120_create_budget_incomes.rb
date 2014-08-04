class CreateBudgetIncomes < ActiveRecord::Migration
  def change
    create_table :budget_incomes do |t|
      t.references :budget, index: true
      t.string :item
      t.decimal :income, :precision => 10, :scale => 2
      t.string :incomebreakdown

      t.timestamps
    end
  end
end
