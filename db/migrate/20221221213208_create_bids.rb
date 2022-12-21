class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.references :offer, null: false, foreign_key: true
      t.string :password_digest
      t.integer :price_in_cents
      t.string :buyer_name

      t.timestamps
    end
  end
end
