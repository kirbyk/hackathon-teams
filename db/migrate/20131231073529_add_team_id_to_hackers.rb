class AddTeamIdToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :team_id, :integer
    add_index :hackers, :team_id
  end
end
