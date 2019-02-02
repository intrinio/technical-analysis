module TechnicalAnalysis
  class Vpt < Indicator

    def self.indicator_symbol
      "vpt"
    end

    def self.indicator_name
      "Volume-price Trend"
    end

    def self.valid_options
      []
    end

    def self.validate_options(options)
      return true if options == {}
      raise ValidationError.new "This indicator doesn't accept any options."
    end

    def self.min_data_size(**params)
      2
    end

    # Calculates the volume-price trend (VPT) for the data
    # https://en.wikipedia.org/wiki/Volume%E2%80%93price_trend
    #
    # @param data [Array] Array of hashes with keys (:date_time, :close, :volume)
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, 2)

      data = data.sort_by_hash_date_time_asc

      output = []
      prev_price = data.shift
      prev_pvt = 0

      data.each do |v|
        pvt = prev_pvt + (((v[:close] - prev_price[:close]) / prev_price[:close]) * v[:volume])
        output << { date_time: v[:date_time], value: pvt }
        prev_price = v
        prev_pvt = pvt
      end

      output
    end

  end
end
