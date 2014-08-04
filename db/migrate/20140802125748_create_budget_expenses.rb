class CreateBudgetExpenses < ActiveRecord::Migration
  def change
    create_table :budget_expenses do |t|
      t.references :budget, index: true
      t.string :item
      t.decimal :requestsac, :precision => 10, :scale => 2
      t.decimal :requestreserves, :precision => 10, :scale => 2
      t.decimal :unitcost, :precision => 10, :scale => 2
      t.integer :quantity
      t.string :justification
      t.string :quotation

      t.timestamps
    end
  end
end
