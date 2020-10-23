# Implementing a new Future Exchange

Implementing a new Future Exchange is identical to https://github.com/coingecko/cryptoexchange/wiki/Implementing-a-New-Exchange-(HTTP-API) except several things to watch out for below

Things to pay attention to

Futures/Derivatives exchange can display their ticker volume in number of contracts, base, target
Keep in mind the volume should always be in terms of base regardless of the unit the exchange returns
Futures/Derivatives exchange sometimes display bilateral volume (meaning double counting the volume for tickers) refers to https://github.com/coingecko/cryptoexchange/blob/master/lib/cryptoexchange/exchanges/huobi_dm/services/market.rb you need to halve that.
