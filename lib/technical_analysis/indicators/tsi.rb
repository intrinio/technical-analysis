module TechnicalAnalysis
  class Tsi

    # Calculates the true strenth index for the data over the given period
    # https://en.wikipedia.org/wiki/True_strength_index
    # 
    # @param data [Array] Array of hashes with keys (:date, :value)
    # @param high_period [Integer] The given high period to calculate the EMA
    # @param low_period [Integer] The given low period to calculate the EMA
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, low_period: 13, high_period: 25, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, low_period + high_period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      high_emas = []
      low_emas = []
      high_multiplier = (2.0 / (high_period + 1.0))
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

            output << { date: v[:date], value: ((100 * (low_ema[:value] / low_ema[:abs_value]))) }

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
        value = data.map { |d| d[:value] }.sum / period.to_f
        abs_value = data.map { |d| d[:abs_value] }.sum / period.to_f
      else
        prev_value = store.last
        value = ((multiplier * (current_value[:value] - prev_value[:value])) + prev_value[:value])
        abs_value = ((multiplier * (current_value[:abs_value] - prev_value[:abs_value])) + prev_value[:abs_value])
      end

      { value: value, abs_value: abs_value }
    end

  end
end
