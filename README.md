# Basic Rails auction API

## Dependencies
* Ruby v3.1.2

## Get started
```
bundle
bundle exec rails db:drop db:setup
```

## Run specs
```
bundle exec rspec
```

## How to play
Start with `rails s`

Use curl requests as long as no frontend for this is build:
```
curl -X POST "localhost:3000/create_offer" -H "accept: */*" -H "Content-Type: application/json" -d '{"offer":{"title": "My Offer", "description":"My description", "offer_price": "123.45","password":"password"}}'

=> {"id":1,"title":"My Offer","description":"My description","price":"123.45","bids":[],"open":true}
```