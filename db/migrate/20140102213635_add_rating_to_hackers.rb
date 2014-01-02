class AddRatingToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :rating, :float
  end
end
