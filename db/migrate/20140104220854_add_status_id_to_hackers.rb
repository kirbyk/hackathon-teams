class AddStatusIdToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :status_id, :integer
  end
end
