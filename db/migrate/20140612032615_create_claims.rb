class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :claimid
      t.string :userid
      t.string :clubid
      t.decimal :amount
      t.string :status
      t.string :category

      t.timestamps
    end
  end
end
