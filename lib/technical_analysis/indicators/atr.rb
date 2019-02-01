module TechnicalAnalysis
  class Atr < Indicator

    def self.indicator_symbol
      "atr"
    end

    def self.indicator_name
      "Average True Range"
    end

    def self.min_data_size(period: 14)
      period + 1
    end

    # Calculates the average true range (ATR) for the data over the given period
    # https://en.wikipedia.org/wiki/Average_true_range
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the ATR
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 14)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period + 1)

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []
      prev_price = data.shift

      data.each do |v|
        tr = StockCalculation.true_range(v[:high], v[:low], prev_price[:close])

        period_values << tr

        if period_values.size == period
          if output.empty?
            atr = period_values.average
          else
            atr = (output.last[:value] * (period - 1.0) + tr) / period.to_f
          end

          output << { date_time: v[:date_time], value: atr }

          period_values.shift
        end

        prev_price = v
      end

      output
    end

  end
end
