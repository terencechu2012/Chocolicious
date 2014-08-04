class AddJustificationToReserves < ActiveRecord::Migration
  def change
    add_column :reserve_accounts, :justification, :longtext
  end
end
