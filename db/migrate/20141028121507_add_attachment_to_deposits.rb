class AddAttachmentToDeposits < ActiveRecord::Migration
  def self.up
    add_attachment :deposits, :supportdoc
  end

  def self.down
    remove_attachment :deposits, :supportdoc
  end
end
