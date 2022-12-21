# frozen_string_literal: true

class OffersController < ApplicationController
  def create
    offer = Offer.create_from_params(create_params)
    render json: offer, status: :created
  end

  def index
    render json: Offer.open_for_bids
  end

  def show
    render json: Offer.find_by!(params[:id]), include: :bids
  end

  def close
    offer = Offer.find(close_params[:id])
    if offer.authenticate(close_params[:password])
      offer.update!(open: false)
      render json: offer
    end
  end

  private

  def create_params
    params.require(:offer).permit(:title, :description, :password, :offer_price)
  end


  def close_params
    params.require(:offer).permit(:id, :password)
  end
end
