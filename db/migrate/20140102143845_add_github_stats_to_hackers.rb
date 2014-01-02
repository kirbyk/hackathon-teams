class AddGithubStatsToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :g_contributions, :integer
    add_column :hackers, :g_followers, :integer
    add_column :hackers, :g_stars, :integer
  end
end
