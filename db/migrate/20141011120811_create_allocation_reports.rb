class CreateAllocationReports < ActiveRecord::Migration
  def change
    create_table :allocation_reports do |t|

      t.timestamps
    end
  end
end
