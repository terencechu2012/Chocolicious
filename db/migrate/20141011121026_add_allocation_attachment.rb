class AddAllocationAttachment < ActiveRecord::Migration
  def self.up
    add_attachment :allocation_reports, :report
  end

  def self.down
    remove_attachment :allocation_reports, :report
  end
end
