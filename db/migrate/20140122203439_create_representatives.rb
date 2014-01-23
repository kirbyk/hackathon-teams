class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
      t.string :fname
      t.string :lname
      t.string :title
      t.string :email

      t.timestamps
    end
  end
end
