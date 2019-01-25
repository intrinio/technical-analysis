module TechnicalAnalysis
  class Dc

    # Calculates the donchian channel (DC) for the data over the given period
    # https://en.wikipedia.org/wiki/Donchian_channel
    # 
    # @param data [Array] Array of hashes with keys (:date, :value)
    # @param period [Integer] The given period to calculate the DC
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 20, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      output = []
      period_values = []

      data.each do |v|
        period_values << v[price_key]

        if period_values.size == period
          output << {
            date: v[:date],
            value: {
              upper_bound: period_values.max,
              lower_bound: period_values.min
            }
          }

          period_values.shift
        end
      end

      output
    end

  end
end
