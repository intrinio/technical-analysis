module TechnicalAnalysis
  class Obv

    # Calculates the on-balance volume (OBV) for the data over the given period
    # https://en.wikipedia.org/wiki/On-balance_volume
    # 
    # @param data [Array] Array of hashes with keys (:date, :close, :volume)
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, 1)

      data = data.sort_by_hash_date_asc

      current_obv = 0
      output = []
      prior_close = nil
      prior_volume = nil

      data.each do |v|
        volume = v[:volume]
        close = v[:close]

        unless prior_close.nil?
          current_obv += volume if close > prior_close
          current_obv -= volume if close < prior_close
        end

        output << { date: v[:date], value: current_obv }

        prior_volume = volume
        prior_close = close
      end

      output
    end

  end
end
