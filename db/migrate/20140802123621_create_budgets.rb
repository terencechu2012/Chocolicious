class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :clubid
      t.integer :year
      t.integer :semester
      t.string :event
      t.date :startdate
      t.date :enddate
      t.integer :estnopar
      t.string :category
      t.decimal :requestsac, :precision => 10, :scale => 2
      t.decimal :requestreserves, :precision => 10, :scale => 2
      t.decimal :projectedincome, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
