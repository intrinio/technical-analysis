module TechnicalAnalysis
  class Fi

    # Calculates the force index (FI) for the data
    # https://en.wikipedia.org/wiki/Force_index
    # 
    # @param data [Array] Array of hashes with keys (:date, :close, :volume)
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, 2)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      output = []
      prev_price = data.shift

      data.each do |v|
        fi = ((v[:close] - prev_price[:close]) * v[:volume])
        output << { date: v[:date], value: fi }
        prev_price = v
      end

      output
    end

  end
end
