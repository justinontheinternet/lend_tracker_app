class ChangeUserTable < ActiveRecord::Migration
  def change

    change_table :users do |t|
      t.remove :name
      t.string :user_name
      t.string :password
    end
  end
end
