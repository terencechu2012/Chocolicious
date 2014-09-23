class CreateEreceipts < ActiveRecord::Migration
  def change
    create_table :ereceipts do |t|
      t.string :issuerid
      t.string :issuername
      t.string :payeename
      t.string :payeemail
      t.decimal :amount
      t.decimal :gst
      t.string :paytype
      t.string :description
      t.string :clubid

      t.timestamps
    end
  end
end
