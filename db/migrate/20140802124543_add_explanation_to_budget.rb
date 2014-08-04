class AddExplanationToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :explanation, :longtext
  end
end
