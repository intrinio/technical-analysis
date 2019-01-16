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

      abs_momentum_data = []
      high_emas = []
      high_ema_abs_values = []
      high_ema_values = []
      low_emas = []
      high_multiplier = (2.0 / (high_period + 1.0))
      low_multiplier = (2.0 / (low_period + 1.0))
      momentum_data = []
      new_data = []
      output = []
      prev_price = data.first[price_key]

      data.shift

      # Use data array to create new array (high_emas) of hashes with keys :date, :value, and :abs_value
      # value - high period EMA of momentum
      # abs_value - high period EMA of absolute momentum
      data.each do |v|
        current_price = v[price_key]
        momentum = current_price - prev_price

        momentum_data << momentum
        abs_momentum_data << momentum.abs

        if momentum_data.size == high_period && abs_momentum_data.size == high_period
          value = nil
          abs_value = nil

          if high_emas.empty?
            value = momentum_data.sum / high_period.to_f
            abs_value = abs_momentum_data.sum / high_period.to_f
          else
            value = (high_emas.last[:value] + (high_multiplier * (momentum - high_emas.last[:value])))
            abs_value = (high_emas.last[:abs_value] + (high_multiplier * (momentum.abs - high_emas.last[:abs_value])))
          end

          high_emas << { date: v[:date], value: value, abs_value: abs_value }

          momentum_data.shift
          abs_momentum_data.shift
        end

        prev_price = current_price
      end

      # Use high_emas array to create new array (low_emas) of hashes with keys :date, :value, and :abs_value
      # value - low period EMA of high period EMA of momentum
      # abs_value - low period EMA of high period EMA of absolute momentum
      high_emas.each do |v|
        high_ema_values << v[:value]
        high_ema_abs_values << v[:abs_value]

        if high_ema_values.size == low_period && high_ema_abs_values.size == low_period
          if low_emas.empty?
            value = high_ema_values.sum / low_period.to_f
            abs_value = high_ema_abs_values.sum / low_period.to_f
          else
            value = (low_emas.last[:value] + (low_multiplier * (v[:value] - low_emas.last[:value])))
            abs_value = (low_emas.last[:abs_value] + (low_multiplier * (v[:abs_value] - low_emas.last[:abs_value])))
          end

          low_emas << { date: v[:date], value: value, abs_value: abs_value }

          high_ema_values.shift
          high_ema_abs_values.shift
        end
      end

      # Use low_emas array of hashes with keys :date, :value, and :abs_value to calculate TSI
      low_emas.each do |v|
        output << { date: v[:date], value: ((100 * (v[:value] / v[:abs_value]))) }
      end
      
      output
    end

  end
end
