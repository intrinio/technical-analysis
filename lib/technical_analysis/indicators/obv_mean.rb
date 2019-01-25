module TechnicalAnalysis
  class ObvMean

    # Calculates the on-balance volume mean (OBV mean) for the data over the given period
    # https://en.wikipedia.org/wiki/On-balance_volume
    # 
    # @param data [Array] Array of hashes with keys (:date, :close, :volume)
    # @param period [Integer] The given period to calculate the OBV mean
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 10)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      current_obv = 0
      obvs = []
      output = []
      prior_close = nil
      prior_volume = nil

      data.each do |v|
        volume = v[:volume]
        close = v[:close]

        unless prior_close.nil?
          current_obv += volume if close > prior_close
          current_obv -= volume if close < prior_close
          obvs << current_obv
        end

        prior_volume = volume
        prior_close = close

        if obvs.size == period
          output << { date: v[:date], value: obvs.average }
          obvs.shift
        end
      end

      output
    end

  end
end
