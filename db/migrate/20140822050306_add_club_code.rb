class AddClubCode < ActiveRecord::Migration
  def change
    add_column :clubs, :clubcode, :string
  end
end
