# Implementing a New Exchange (Websocket API)

Note: As Websocket API is a newly implemented interface, this documentation is WIP and welcome feedback and suggestions to improve clarity.

Step 1
When choosing an exchange to implement, it is important to understand the Websocket API response and structure. Find out what data attributes are returned, do they support Ticker, Orderbook, and Trades, is the base/target swapped, is the volume denominated in the base currency or target currency, is there a rate limit, do you need to make a single websocket call or multiple websocket calls when needing to query multiple pairs, etc.

Step 2
Create market_stream.rb, order_book_stream.rb, trade_stream.rb in an existing exchange directory

Step 3
Assign the websocket API root api endpoint url to WS_URL in market.rb

Step 4
When working on websocket API, it is typically done on an existing implemented exchange for HTTP API. Pairs list can be obtained by calling the pairs method from the client

Step 5
Create a services/market_stream.rb to connect with websocket. You will need to send the parameters according to the exchange websocket API requirement. At this point, all the exchange APIs may return response in a different manner. You will want to create an parse_message method to convert the API response to be assigned to our generic Cryptoexchange::Models::Ticker

Step 6
(TBD) How to structure if a single websocket connection is needed to get all data or multiple websocket connections for individual pairs. The example on Bitfinex is for the multiple connections.

Step 7
(TBD) There seem to be no way to use VCR to easily mock websocket calls. We will need to think of something in order to run integration tests. Otherwise we will have to settle with a unit test with manual mock of the response, not ideal.

Step 8
Make sure the base, target, volume, and all attributes are assigned correctly. It can get really confusing when exchanges are returning these data in a different manner. Given pair of BTC/USD, BTC is the base, USD is the target volume should always be in the base currency When in doubt, refer to our existing implementations

Some things to take note
When implementing Ticker, make sure the base, target, and volume are assigned correctly.
For example if a pair is BTC/USD, BTC is the base and USD is the target
Another example, if a pair is DOGE/ETH, DOGE is the base and ETH is the target
Some exchanges may not follow convention and get this mixed up
volume is denominated in the base currency
For example if a pair is BTC/USD, the volume should be in BTC
If the Ticker, Orderbook, or Trades do not return a timestamp, assign nil
