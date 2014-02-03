class AddCellToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :cell, :string
  end
end
