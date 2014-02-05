class AddTechTalkTimeToSponsors < ActiveRecord::Migration
  def change
  	add_column :sponsors, :tech_talk_time, :string
  end
end
