class AddNricToUser < ActiveRecord::Migration
  def change
    add_column :users, :nric, :string
  end
end
