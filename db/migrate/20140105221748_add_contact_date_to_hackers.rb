class AddContactDateToHackers < ActiveRecord::Migration
  def change
    add_column :hackers, :contact_date, :string
  end
end
