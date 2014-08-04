class AddNricEventsColumnsToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :nric, :string
    add_column :claims, :event, :string
  end
end
