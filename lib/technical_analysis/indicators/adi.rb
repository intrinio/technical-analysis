module TechnicalAnalysis
  class Adi
    # Calculates the Accumulation/Distribution Index for the data over the given period
    # https://en.wikipedia.org/wiki/Accumulation/distribution_index
    # 
    # @param data [Hash] Date strings to hash with keys (:high, :low, :close, :volume)
    # @return [Hash] A hash of date strings to ADI values
    def self.calculate(data)
      # Validation.validate_price_data(data)
      # Validation.validate_length(data, period)
      
      ads = {}
      data = data.sort.to_h # Sort data by descending dates

      data.each do |date, values|
        clv = 0
        if values[:high] > values[:low]
          clv = ((values[:close] - values[:low]) - (values[:high] - values[:close])) / (values[:high] - values[:low])
        end
        ad = clv * values[:volume]
        ads[date] = ad
      end

      keys = ads.keys
      (1..keys.size-1).each do |index|
        cur_key = keys[index]
        prev_key = keys[index-1]
        ads[cur_key] = ads[cur_key] + ads[prev_key]
      end

      ads
    end
  end
end
