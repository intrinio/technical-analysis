module TechnicalAnalysis
  class Wr

    # Calculates the Williams %R for the data over the given period
    # https://en.wikipedia.org/wiki/Williams_%25R
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :close)
    # @param period [Integer] The given look-back period to calculate the Williams %R
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 14)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      highs = []
      lows = []
      output = []

      data.each do |v|
        lows << v[:low]
        highs << v[:high]

        if lows.size == period && highs.size == period
          lowest_low = lows.min
          highest_high = highs.max

          wr = (highest_high - v[:close]) / (highest_high - lowest_low) * -100

          output << { date: v[:date], value: wr }

          lows.shift
          highs.shift
        end
      end

      output
    end

  end
end
