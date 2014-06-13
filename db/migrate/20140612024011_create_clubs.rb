class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :clubid
      t.string :finsecid
      t.string :presidentid
      t.string :clubtype
      t.string :clubname

      t.timestamps
    end
  end
end
