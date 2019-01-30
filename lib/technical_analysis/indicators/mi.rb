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

      data = data.sort_by_hash_date_asc

      double_emas = []
      high_low_diffs = []
      output = []
      ratio_of_emas = []
      single_emas = []

      data.each do |v|
        high_low_diff = v[:high] - v[:low]
        high_low_diffs << high_low_diff

        if high_low_diffs.size == ema_period
          single_ema = StockCalculation.ema(high_low_diff, high_low_diffs, ema_period, single_emas.last)
          single_emas << single_ema

          if single_emas.size == ema_period
            double_ema = StockCalculation.ema(single_emas.last, single_emas, ema_period, double_emas.last)
            double_emas << double_ema

            ratio_of_emas << (single_ema / double_ema)

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

  end
end
