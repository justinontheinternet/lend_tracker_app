class AddItems < ActiveRecord::Migration
  def change

    create_table :items do |t|
      t.references :user
      t.string :name
      t.text :description
    end
  end
end
