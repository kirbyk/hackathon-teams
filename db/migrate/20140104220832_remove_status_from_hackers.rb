class RemoveStatusFromHackers < ActiveRecord::Migration
  def change
    remove_column :hackers, :status, :string
  end
end
