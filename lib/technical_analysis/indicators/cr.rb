module TechnicalAnalysis
  class Cr

    # Calculates the cumulative return for the data over the given period
    # https://www.investopedia.com/terms/c/cumulativereturn.asp
    # 
    # @param data [Array] Array of hashes with keys (:date, :value)
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, 1)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      output = []
      start_price = data.first[price_key] 
      puts start_price

      data.each do |v|
        output << { date: v[:date], value: ((v[price_key] - start_price) / start_price) }
      end

      output
    end

  end
end
