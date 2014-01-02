class AddHackerIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :hacker_id, :integer
    add_index :ratings, :hacker_id
  end
end
