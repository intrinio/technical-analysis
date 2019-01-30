module TechnicalAnalysis
  class Eom

    # Calculates the ease of movement (EoM and EVM) for the data over the given period
    # https://en.wikipedia.org/wiki/Ease_of_movement
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :volume)
    # @param period [Integer] The given period to calculate the Eom / EVM
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 14)
      Validation.validate_numeric_data(data, :high, :low, :volume)
      Validation.validate_length(data, period + 1)

      data = data.sort_by_hash_date_asc

      output = []
      period_values = []
      prev_price = data.shift

      data.each do |v|
        distance_moved = ((v[:high] + v[:low]) / 2) - ((prev_price[:high] + prev_price[:low]) / 2)
        box_ratio = (v[:volume] / 100_000_000.00) / (v[:high] - v[:low])
        emv = distance_moved / box_ratio

        period_values << emv

        if period_values.size == period
          output << { date: v[:date], value: period_values.average }
          period_values.shift
        end

        prev_price = v
      end

      output
    end

  end
end
