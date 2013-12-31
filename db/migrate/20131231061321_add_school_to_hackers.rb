class AddSchoolToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :school_id, :integer
    add_index :hackers, :school_id
  end
end
