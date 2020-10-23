# Implementing a New Exchange (HTTP API)

Step 1
When choosing an exchange to implement, it is important to understand the API response and structure. Find out what data attributes are returned, do they support Ticker, Orderbook, and Trades, is the base/target swapped, is the volume denominated in the base currency or target currency, is there a rate limit, etc.

Step 2
Create a directory with the name under lib/cryptoexchange/exchanges

Step 3
Create a market.rb with the NAME of the exchange and API_URL which is the root api endpoint url

Step 4
Create a services/pairs.rb to query the API in order to fetch the list of trading pairs supported by the exchange. If there is no API supported for this, create a <exchange>.yml to define the pairs for example. This yml can be customized by the gem user to add more pairs without a pull request.

Step 5
Create a services/market.rb to query the API to fetch Ticker, Orderbook, or Trades using the Pair. At this point, all the exchange APIs may return response in a different manner. You will want to create an adapt method to convert the API response to be assigned to our generic Cryptoexchange::Models::Ticker

Step 6
If the API supports a single API call that returns all trading pair tickers, favor that instead of an API call for each pair. Implement that by setting supports_individual_ticker_query? to false with an adapt_all method. Example here.

Step 7
Write specs. Create a directory under spec/exchange/<exchange>. Write a market_spec.rb to test the Market constants and an integration test integration/market_spec.rb. Test at least a method fetching pairs, tickers, orderbooks, and trades. All specs that makes HTTP call will have the response saved using VCR. VCR mocks the API response such that the responses would be consistent and do not require us to hit the actual API. Commit the VCR cassettes as well alongside your changes.

Step 8
Make sure the base, target, volume, and all attributes are assigned correctly. It can get really confusing when exchanges are returning these data in a different manner. Given pair of BTC/USD, BTC is the base, USD is the target volume should always be in the base currency When in doubt, refer to our existing implementations

Some things to take note
When implementing Ticker, make sure the base, target, and volume are assigned correctly.
For example if a pair is BTC/USD, BTC is the base and USD is the target
Another example, if a pair is DOGE/ETH, DOGE is the base and ETH is the target
Some exchanges may not follow convention and get this mixed up
volume is denominated in the base currency
For example if a pair is BTC/USD, the volume should be in BTC
We started using VCR to mock out the response in our specs, because our integration test have always been failing to mock out the response in our specs, because our integration test have always been failing
If you are implementing a new exchange API in your branch, chances are there is no VCR casette for the API response yet
In this case calling rspec spec/exchanges/<someexchange> will hit the API for the first time and save the response in the fixtures directory
Commit the VCR cassette, but do not override or include overrides of existing VCR casettes in your pull request unless there is a good reason to do so
If the Ticker, Orderbook, or Trades do not return a timestamp, assign nil

