class AddMiniHackToSponsors < ActiveRecord::Migration
  def change
  	add_column :sponsors, :mini_hack, :boolean
  end
end
