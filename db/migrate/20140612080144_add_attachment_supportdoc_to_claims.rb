class AddAttachmentSupportdocToClaims < ActiveRecord::Migration
  def self.up
    change_table :claims do |t|

      t.attachment :supportdoc

    end
  end

  def self.down

    drop_attached_file :claims, :supportdoc

  end
end
