class AddStatusToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :status, :string
  end
end
