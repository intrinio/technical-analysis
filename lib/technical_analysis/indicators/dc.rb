module TechnicalAnalysis
  class Dc < Indicator

    def self.indicator_symbol
      "dc"
    end

    def self.indicator_name
      "Donchian Channel"
    end

    def self.valid_options
      %i(period price_key)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(period: 20, **params)
      period.to_i
    end

    # Calculates the donchian channel (DC) for the data over the given period
    # https://en.wikipedia.org/wiki/Donchian_channel
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the DC
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 20, price_key: :value)
      period = period.to_i
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        period_values << v[price_key]

        if period_values.size == period
          output << {
            date_time: v[:date_time],
            value: {
              upper_bound: period_values.max,
              lower_bound: period_values.min
            }
          }

          period_values.shift
        end
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
