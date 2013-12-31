class CreateHackers < ActiveRecord::Migration
  def change
    create_table :hackers do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :github
      t.string :tshirt_size
      t.text :why

      t.timestamps
    end
  end
end
