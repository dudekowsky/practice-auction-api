# frozen_string_literal: true

class Bid < ApplicationRecord
  has_secure_password

  belongs_to :offer

  def self.create_from_params(params)
    bid = new(params.except(:amout))
    bid.amount = params[:amount]
    bid.save!
    bid
  end

  def amount
    format('%.2f', (price_in_cents / 100.0))
  end

  def amount=(amount)
    self.price_in_cents = amount.to_f * 100
  end

  def as_json(_options = {})
    { amount:,
      buyer_name:,
      id:,
      offer_id: }
  end
end
