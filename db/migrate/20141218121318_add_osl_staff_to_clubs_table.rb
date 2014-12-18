class AddOslStaffToClubsTable < ActiveRecord::Migration
  def change
    add_column :clubs, :oslstaff, :string 
  end
end
