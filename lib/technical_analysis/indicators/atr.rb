module TechnicalAnalysis
  class Atr

    # Calculates the average true range (ATR) for the data over the given period
    # https://en.wikipedia.org/wiki/Average_true_range
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :close)
    # @param period [Integer] The given period to calculate the ATR
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 14)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period + 1)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      output = []
      period_values = []
      prev_price = data.shift

      data.each do |v|
        tr = [
          (v[:high] - v[:low]),
          (v[:high] - prev_price[:close]).abs,
          (v[:low] - prev_price[:close]).abs
        ].max

        period_values << tr

        if period_values.size == period
          if output.empty?
            atr = period_values.sum / period.to_f
          else
            atr = (output.last[:value] * (period - 1.0) + tr) / period.to_f
          end

          output << { date: v[:date], value: atr }

          period_values.shift
        end

        prev_price = v
      end

      output
    end

  end
end
