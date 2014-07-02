class Addremarkcolumntoclaims < ActiveRecord::Migration
  def change
    add_column :claims, :remarks, :string
  end
end
