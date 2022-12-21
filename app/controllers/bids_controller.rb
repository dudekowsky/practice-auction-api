# frozen_string_literal: true

class BidsController < ApplicationController
  def create
    render json: Bid.create_from_params(create_params), status: :created
  end

  def delete
    bid = Bid.find(delete_params[:id])
    if bid.authenticate(delete_params[:password])
      if bid.offer.open?
        bid.destroy!
      else
        head :conflict
      end
    else
      head :unauthenticated
    end
  end

  private

  def create_params
    params.require(:bid).permit(:offer_id, :buyer_name, :password, :amount)
  end

  def delete_params
    params.require(:bid).permit(:id, :password)
  end
end
