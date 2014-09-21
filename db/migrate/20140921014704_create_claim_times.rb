class CreateClaimTimes < ActiveRecord::Migration
  def change
    create_table :claim_times do |t|
      t.integer :claimid
      t.integer :status
      t.date :date

      t.timestamps
    end
  end
end
