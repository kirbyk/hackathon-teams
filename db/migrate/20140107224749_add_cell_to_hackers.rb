class AddCellToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :cell, :string
  end
end
