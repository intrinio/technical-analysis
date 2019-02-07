module TechnicalAnalysis
  class Vpt < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "vpt"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Volume-price Trend"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      []
    end

    # Validates the provided options for this technical indicator
    #
    # @param options [Hash] The options for the technical indicator to be validated
    #
    # @return [Boolean] Returns true if options vare valid or raises an error if they're not
    def self.validate_options(options)
      return true if options == {}
      raise Validation::ValidationError.new "This indicator doesn't accept any options."
    end

    # Calculates the minimum number of observations needed to calculate the technical indicator
    #
    # @param options [Hash] The options for the technical indicator
    #
    # @return [Integer] Returns the minimum number of observations needed to calculate the technical
    #    indicator based on the options provided
    def self.min_data_size(**params)
      2
    end

    # Calculates the volume-price trend (VPT) for the data
    # https://en.wikipedia.org/wiki/Volume%E2%80%93price_trend
    #
    # @param data [Array] Array of hashes with keys (:date_time, :close, :volume)
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => -27383899.78109331},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => -28148662.548589166},
    #     ]
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

      output.sort_by_hash_date_time_desc
    end

  end
end
