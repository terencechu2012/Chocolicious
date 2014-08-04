class AddPosterAttachmentToBudget < ActiveRecord::Migration
  def self.up
    add_attachment :budgets, :poster
  end

  def self.down
    remove_attachment :budgets, :poster
  end
end
