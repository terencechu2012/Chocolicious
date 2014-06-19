class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :userid
      t.string :clubid

      t.timestamps
    end
  end
end
