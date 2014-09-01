class AddExpenseToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :expense, :string
  end
end
