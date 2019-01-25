module TechnicalAnalysis
  class Mi

    # Calculates the mass index (MI) for the data over the given period
    # https://en.wikipedia.org/wiki/Mass_index
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low)
    # @param ema_period [Integer] The given period to calculate the EMA and EMA of EMA
    # @param period [Integer] The given period to calculate the MI
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, ema_period: 9, sum_period: 25)
      Validation.validate_numeric_data(data, :high, :low)
      Validation.validate_length(data, (ema_period * 2) + sum_period - 2)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      double_emas = []
      high_low_diffs = []
      multiplier = 2.0 / (ema_period + 1.0)
      output = []
      ratio_of_emas = []
      single_emas = []

      data.each do |v|
        high_low_diff = v[:high] - v[:low]
        high_low_diffs << high_low_diff

        if high_low_diffs.size == ema_period
          single_emas = process_ema(high_low_diff, high_low_diffs, multiplier, ema_period, single_emas)

          if single_emas.size == ema_period
            double_emas = process_ema(single_emas.last, single_emas, multiplier, ema_period, double_emas)

            ratio_of_emas << (single_emas.last / double_emas.last)

            if ratio_of_emas.size == sum_period
              output << { date: v[:date], value: ratio_of_emas.sum }

              double_emas.shift
              ratio_of_emas.shift
            end

            single_emas.shift
          end

          high_low_diffs.shift
        end
      end

      output
    end

    def self.process_ema(current_value, data, multiplier, period, store)
      if store.empty?
        store << data.sum / period.to_f
      else
        prev_value = store.last
        store << ((multiplier * (current_value - prev_value)) + prev_value)
      end

      store
    end

  end
end
