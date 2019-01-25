module TechnicalAnalysis
  class Cci

    # Calculates the commodity channel index for the data over the given period
    # https://en.wikipedia.org/wiki/Commodity_channel_index
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :close)
    # @param period [Integer] The given period to calculate the CCI
    # @param constant [Float] The given constant to ensure that approximately 70 to 80 percent of CCI values would fall between −100 and +100
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 20, constant: 0.015)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      output = []
      typical_prices = []

      data.each do |v|
        typical_price = StockCalculation.typical_price(v)
        typical_prices << typical_price

        if typical_prices.size == period
          period_sma = typical_prices.average
          mean_deviation = typical_prices.map { |tp| (tp - period_sma).abs }.mean
          cci = (typical_price - period_sma) / (constant * mean_deviation)

          output << { date: v[:date], value: cci }
          typical_prices.shift
        end
      end

      output
    end

  end
end
