class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.decimal :rate, :precision => 5, :scale => 2

      t.timestamps
    end
  end
end
