class OffersController < ApplicationController
  def create
    offer = Offer.create_from_params(create_params)
    render json: offer, status: :created
  end

  def index
    render json: Offer.open_for_bids
  end

  def show
    render json: Offer.find_by!(params[:id])
  end

  private 

  def create_params
    params.require(:offer).permit(:title, :description, :password, :offer_price )
  end
end
