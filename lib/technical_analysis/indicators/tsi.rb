module TechnicalAnalysis
  class Tsi < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "tsi"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "True Strength Index"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(low_period high_period price_key)
    end

    # Validates the provided options for this technical indicator
    #
    # @param options [Hash] The options for the technical indicator to be validated
    #
    # @return [Boolean] Returns true if options are valid or raises a ValidationError if they're not
    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    # Calculates the minimum number of observations needed to calculate the technical indicator
    #
    # @param options [Hash] The options for the technical indicator
    #
    # @return [Integer] Returns the minimum number of observations needed to calculate the technical
    #    indicator based on the options provided
    def self.min_data_size(low_period: 13, high_period: 25, **params)
      low_period.to_i + high_period.to_i
    end

    # Calculates the true strength index (TSI) for the data over the given period
    # https://en.wikipedia.org/wiki/True_strength_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param high_period [Integer] The given high period to calculate the EMA
    # @param low_period [Integer] The given low period to calculate the EMA
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => -28.91017661103889},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => -30.97413963420104},
    #     ]
    def self.calculate(data, low_period: 13, high_period: 25, price_key: :value)
      low_period = low_period.to_i
      high_period = high_period.to_i
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size(low_period: low_period, high_period: high_period))

      data = data.sort_by_hash_date_time_asc

      high_emas = []
      high_multiplier = (2.0 / (high_period + 1.0))
      low_emas = []
      low_multiplier = (2.0 / (low_period + 1.0))
      momentum_values = []
      output = []
      prev_price = data.shift[price_key]

      data.each do |v|
        current_price = v[price_key]
        momentum = current_price - prev_price
        momentum_hash = { value: momentum, abs_value: momentum.abs }

        momentum_values << momentum_hash

        if momentum_values.size == high_period
          high_emas << process_ema(momentum_hash, momentum_values, high_multiplier, high_period, high_emas)

          if high_emas.size == low_period
            low_ema = process_ema(high_emas.last, high_emas, low_multiplier, low_period, low_emas)
            low_emas << low_ema

            output << { date_time: v[:date_time], value: ((100 * (low_ema[:value] / low_ema[:abs_value]))) }

            low_emas.shift if low_emas.size > 1 # Only need to retain the last low_ema
            high_emas.shift
          end

          momentum_values.shift
        end

        prev_price = current_price
      end
      
      output.sort_by_hash_date_time_desc
    end

    private_class_method def self.process_ema(current_value, data, multiplier, period, store)
      if store.empty?
        value = data.map { |d| d[:value] }.average
        abs_value = data.map { |d| d[:abs_value] }.average
      else
        prev_value = store.last
        value = ((multiplier * (current_value[:value] - prev_value[:value])) + prev_value[:value])
        abs_value = ((multiplier * (current_value[:abs_value] - prev_value[:abs_value])) + prev_value[:abs_value])
      end

      { value: value, abs_value: abs_value }
    end

  end
end
