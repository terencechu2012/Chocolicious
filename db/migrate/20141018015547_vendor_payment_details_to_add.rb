class VendorPaymentDetailsToAdd < ActiveRecord::Migration
  def change
    add_column :payments, :vendorpayeename, :string
    add_column :payments, :vendorcontact, :string
  end
end
