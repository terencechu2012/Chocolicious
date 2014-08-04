class CreateBudgetControls < ActiveRecord::Migration
  def change
    create_table :budget_controls do |t|
      t.boolean :open
      t.string :year
      t.integer :semester

      t.timestamps
    end
  end
end
