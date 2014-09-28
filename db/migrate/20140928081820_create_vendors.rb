class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :contact
      t.string :address
      t.integer :category
      t.decimal :price, :precision => 5, :scale => 4
      t.decimal :quality, :precision => 5, :scale => 4
      t.decimal :punctuality, :precision => 5, :scale => 4
      t.decimal :customerservice, :precision => 5, :scale => 4
      t.decimal :overall, :precision => 5, :scale => 4

      t.timestamps
    end
  end
end
