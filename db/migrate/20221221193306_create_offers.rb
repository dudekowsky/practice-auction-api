# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.string :description
      t.string :password_digest
      t.integer :price_in_cents, default: 0
      t.boolean :open, default: true

      t.timestamps
    end
  end
end
