class DeleteColumnFromClaims < ActiveRecord::Migration
  def change
    remove_column :claims, :claimid
  end
end
