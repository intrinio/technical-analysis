module TechnicalAnalysis
  class Tsi < Indicator

    def self.indicator_symbol
      "tsi"
    end

    def self.indicator_name
      "True Strength Index"
    end

    def self.valid_options
      %i(low_period high_period price_key)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(low_period: 13, high_period: 25, **params)
      low_period + high_period
    end

    # Calculates the true strength index (TSI) for the data over the given period
    # https://en.wikipedia.org/wiki/True_strength_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param high_period [Integer] The given high period to calculate the EMA
    # @param low_period [Integer] The given low period to calculate the EMA
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, low_period: 13, high_period: 25, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, low_period + high_period)

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
      
      output
    end

    def self.process_ema(current_value, data, multiplier, period, store)
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
