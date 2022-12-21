class Offer < ApplicationRecord
  has_secure_password

  serialize :title

  validates :password, presence: true
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  
  scope :open_for_bids, -> { where(open: true) }

  def self.create_from_params(params)
    offer = new(params.except :offer_price)
    offer.price = params[:offer_price]
    offer.save!
    offer
  end

  def price
    '%.2f' % (price_in_cents / 100.0)
  end

  def price=(amount)
    self.price_in_cents = amount.to_f * 100
  end

  def as_json(options = {})
    {
      id: id,
      title: title,
      description: description,
      price: price,
    }
  end
end
