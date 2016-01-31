class AddDetailsColumnToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :details, :text
  end
end
