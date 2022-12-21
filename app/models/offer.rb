# frozen_string_literal: true

class Offer < ApplicationRecord
  has_secure_password

  has_many :bids

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true

  scope :open_for_bids, -> { where(open: true) }

  def self.create_from_params(params)
    offer = new(params.except(:offer_price))
    offer.price = params[:offer_price]
    offer.save!
    offer
  end

  # Make sure price is rendered as Decimal
  def price
    format('%.2f', (price_in_cents / 100.0))
  end

  # Make sure price is stored as Integer
  def price=(amount)
    self.price_in_cents = amount.to_f * 100
  end

  # Don't render password etc.
  def as_json(_options = {})
    {
      id:,
      title:,
      description:,
      price:,
      bids:,
      open:
    }
  end
end
