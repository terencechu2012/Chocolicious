class CreateClubusers < ActiveRecord::Migration
  def change
    create_table :clubusers do |t|
      t.string :userid
      t.string :clubid
      t.string :role

      t.timestamps
    end
  end
end
