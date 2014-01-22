class AddSponsorIdToRepresentatives < ActiveRecord::Migration
  def change
  	add_column :representatives, :sponsor_id, :integer
    add_index :representatives, :sponsor_id
  end
end
