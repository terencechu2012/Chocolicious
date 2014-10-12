class CreateRejectedClaims < ActiveRecord::Migration
  def change
    create_table :rejected_claims do |t|
      t.integer :claimid
      t.string :clubid
      t.string :madeby
      t.string :rejectedby
      t.decimal :amount, precision: 10, scale: 2
      t.integer :status
      t.string :remarks

      t.timestamps
    end
  end
end
