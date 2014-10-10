class AddReceiptupdatedatToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :receiptupdatedat, :datetime
  end
end
