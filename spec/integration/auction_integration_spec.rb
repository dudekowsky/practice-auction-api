require 'rails_helper'

RSpec.describe "Auction", type: :request do
  let(:valid_offer_create_params) { {offer: { title: "A valid title", description: "A valid description", offer_price: "100", password: 'supersecurepassword!'} }}
  let(:offer_1_json_response) { 
    @offer1_id ||= Offer.find_by(title: valid_offer_create_params[:offer][:title]).id
    {"id"=> @offer1_id, "title"=>"A valid title", "description"=>"A valid description", "price"=>"100.00"} 
  }
  let(:another_valid_offer_create_params) { {offer: { title: "Another valid title", description: "A valid description", offer_price: "100", password: 'supersecurepassword!'} }}
  let(:offer_2_json_response) { 
    @offer2_id ||= Offer.find_by(title: another_valid_offer_create_params[:offer][:title]).id
    {"id"=> @offer2_id, "title"=>"Another valid title", "description"=>"A valid description", "price"=>"100.00"} 
  }
  describe 'Happy Case' do
    it 'is completely implemented' do
      # Create a simple offer
      post create_offer_path, params: valid_offer_create_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to match(offer_1_json_response)
      
      # List multiple offers
      post create_offer_path, params: another_valid_offer_create_params
      get list_offers_path
      expect(JSON.parse(response.body)).to match([offer_1_json_response, offer_2_json_response])

      # Show offer with empty bids
      
      get get_offer_path, params: { id: @offer1_id }

    end
  end
end