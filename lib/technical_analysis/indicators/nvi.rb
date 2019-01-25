module TechnicalAnalysis
  class Nvi

    # Calculates the negative volume index (NVI) for the data
    # https://en.wikipedia.org/wiki/Negative_volume_index
    # 
    # @param data [Array] Array of hashes with keys (:date, :close, :volume)
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, 1)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      nvi_cumulative = 1_000.00
      output = []
      prev_price = data.shift

      output << { date: prev_price[:date], value: nvi_cumulative } # Start with default of 1_000

      data.each do |v|
        volume_change = ((v[:volume] - prev_price[:volume]) / prev_price[:volume])

        if volume_change < 0
          price_change = ((v[:close] - prev_price[:close]) / prev_price[:close]) * 100.00
          nvi_cumulative += price_change
        end

        output << { date: v[:date], value: nvi_cumulative }
        prev_price = v
      end

      output
    end

  end
end
