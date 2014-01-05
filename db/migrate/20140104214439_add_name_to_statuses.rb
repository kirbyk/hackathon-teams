class AddNameToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :name, :string
  end
end
