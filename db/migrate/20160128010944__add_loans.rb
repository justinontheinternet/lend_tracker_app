class AddLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.references :user
      t.references :item
      t.date :checkout
      t.date :checkin
      t.timestamps
    end

    change_table :users do |t|
      t.timestamps
    end

    change_table :items do |t|
      t.timestamps
    end
  end
end