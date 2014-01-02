class AddRatingAvgToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :rating_avg, :float
  end
end
