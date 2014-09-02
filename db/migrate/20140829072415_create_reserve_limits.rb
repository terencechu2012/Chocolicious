class CreateReserveLimits < ActiveRecord::Migration
  def change
    create_table :reserve_limits do |t|
      t.string :clubid
      t.decimal :amount, precision:10, scale: 2
      t.string :remarks
      
      t.timestamps
    end
  end
end
