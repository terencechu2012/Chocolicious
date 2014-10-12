class Addsupportingdocforpayment < ActiveRecord::Migration
  def self.up
    change_table :payments do |t|
      t.attachment :supportdoc
    end
  end

  def self.down
    drop_attached_file :payments, :supportdoc
  end
end
