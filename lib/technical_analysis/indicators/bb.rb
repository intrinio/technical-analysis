module TechnicalAnalysis
  class Bb < Indicator

    def self.indicator_symbol
      "bb"
    end

    def self.indicator_name
      "Bollinger Bands"
    end

    def self.valid_options
      %i(period standard_deviations price_key)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(period: 20, **params)
      period
    end

    # Calculates the bollinger bands (BB) for the data over the given period
    # https://en.wikipedia.org/wiki/Bollinger_Bands
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the BB
    # @param standard_deviations [Integer] The given standard deviations to calculate the upper and lower bands of the BB
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 20, standard_deviations: 2, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        period_values << v[price_key]

        if period_values.size == period
          mb = period_values.average
          sd = period_values.standard_deviation
          ub = mb + standard_deviations * sd
          lb = mb - standard_deviations * sd

          output << {
            date_time: v[:date_time],
            value: {
              middle_band: mb,
              upper_band: ub,
              lower_band: lb
            }
          }

          period_values.shift
        end
      end

      output
    end

  end
end
