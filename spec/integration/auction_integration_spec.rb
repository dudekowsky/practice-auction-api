# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auction', type: :request do
  let(:valid_offer_create_params) do
    { offer: { title: 'A valid title', description: 'A valid description', offer_price: '100',
               password: 'supersecurepassword!' } }
  end

  let(:create_offer_1_json_response) do
    @offer1_id ||= Offer.find_by(title: valid_offer_create_params[:offer][:title]).id
    { 'id' => @offer1_id, 'title' => 'A valid title', 'description' => 'A valid description', 'price' => '100.00',
      'open' => true, 'bids' => [] }
  end

  let(:another_valid_offer_create_params) do
    { offer: { title: 'Another valid title', description: 'A valid description', offer_price: '100',
               password: 'supersecurepassword!' } }
  end

  let(:create_offer_2_json_response) do
    @offer2_id ||= Offer.find_by(title: another_valid_offer_create_params[:offer][:title]).id
    { 'id' => @offer2_id, 'title' => 'Another valid title', 'description' => 'A valid description', 'open' => true,
      'price' => '100.00', 'bids' => [] }
  end

  let(:create_bid_params) do
    { bid: { offer_id: @offer1_id, buyer_name: 'A valid buyer name', password: 'supersecurepassword!',
             amount: '110.23' } }
  end

  let(:create_bid_json_response) do
    { 'id' => Offer.find(@offer1_id).bids.first.id, 'buyer_name' => 'A valid buyer name', 'offer_id' => @offer1_id,
      'amount' => '110.23' }
  end

  let(:close_offer_params) { { offer: { id: @offer1_id, password: valid_offer_create_params[:offer][:password] } } }

  describe 'Happy Case' do
    it 'is completely implemented' do
      # Create a simple offer
      post create_offer_path, params: valid_offer_create_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to match(create_offer_1_json_response)

      # List multiple offers
      post create_offer_path, params: another_valid_offer_create_params
      get list_offers_path
      expect(JSON.parse(response.body)).to match([create_offer_1_json_response, create_offer_2_json_response])

      # Show offer with empty bids
      get get_offer_path, params: { id: @offer1_id }
      expect(JSON.parse(response.body)).to match(create_offer_1_json_response)

      # Create bid
      post create_bid_path, params: create_bid_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to match(create_bid_json_response)

      # Show offer with a bid
      get get_offer_path, params: { id: @offer1_id }
      expect(JSON.parse(response.body)).to match(create_offer_1_json_response.merge('bids' => [create_bid_json_response]))

      # Delete bid
      delete delete_bid_path,
             params: { bid: { id: create_bid_json_response['id'], password: create_bid_params[:bid][:password] } }
      expect(response).to have_http_status(:no_content)
      get get_offer_path, params: { id: @offer1_id }
      expect(JSON.parse(response.body)).to match(create_offer_1_json_response)

      # Create another bid and close offer
      post create_bid_path, params: create_bid_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to match(create_bid_json_response)
      get get_offer_path, params: { id: @offer1_id }
      expect(JSON.parse(response.body)).to match(create_offer_1_json_response.merge('bids' => [create_bid_json_response]))
      post close_offer_path, params: close_offer_params
      expect(response).to have_http_status(:ok)

      # Make sure bid cannot be deleted afterwards and offer is set to false
      delete delete_bid_path,
             params: { bid: { id: create_bid_json_response['id'], password: create_bid_params[:bid][:password] } }
      expect(response).to have_http_status(:conflict)
      get get_offer_path, params: { id: @offer1_id }
      expect(JSON.parse(response.body)).to match(create_offer_1_json_response.merge(
                                                   'bids' => [create_bid_json_response], 'open' => false
                                                 ))
      # Make sure closed offer is not listed anymore
      get list_offers_path
      expect(JSON.parse(response.body)).to match([create_offer_2_json_response])

    end
  end
end
