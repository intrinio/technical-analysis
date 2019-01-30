module TechnicalAnalysis
  class Vpt

    # Calculates the volume-price trend (VPT) for the data
    # https://en.wikipedia.org/wiki/Volume%E2%80%93price_trend
    # 
    # @param data [Array] Array of hashes with keys (:date, :close, :volume)
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, 2)

      data = data.sort_by_hash_date_asc

      output = []
      prev_price = data.shift
      prev_pvt = 0

      data.each do |v|
        pvt = prev_pvt + (((v[:close] - prev_price[:close]) / prev_price[:close]) * v[:volume])
        output << { date: v[:date], value: pvt }
        prev_price = v
        prev_pvt = pvt
      end

      output
    end

  end
end
