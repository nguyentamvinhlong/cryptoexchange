module Cryptoexchange::Exchanges
  module Hikenex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Hikenex::Market::API_URL}/marketcap"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            target, base = pair['pair'].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Hikenex::Market::NAME
            )
          end
        end
      end
    end
  end
end
