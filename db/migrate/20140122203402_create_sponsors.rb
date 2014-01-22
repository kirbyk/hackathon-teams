class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :company_name
      t.string :tier
      t.integer :money_given
      t.boolean :has_paid

      t.timestamps
    end
  end
end
