module TechnicalAnalysis
  class Fi < Indicator

    def self.indicator_symbol
      "fi"
    end

    def self.indicator_name
      "Force Index"
    end

    def self.min_data_size(**params)
      2
    end

    # Calculates the force index (FI) for the data
    # https://en.wikipedia.org/wiki/Force_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :close, :volume)
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, 2)

      data = data.sort_by_hash_date_time_asc

      output = []
      prev_price = data.shift

      data.each do |v|
        fi = ((v[:close] - prev_price[:close]) * v[:volume])
        output << { date_time: v[:date_time], value: fi }
        prev_price = v
      end

      output
    end

  end
end
