module TechnicalAnalysis
  class Nvi < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "nvi"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Negative Volume Index"
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
      1
    end

    # Calculates the negative volume index (NVI) for the data
    # https://en.wikipedia.org/wiki/Negative_volume_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :close, :volume)
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => 1002.8410612825647},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => 1002.8410612825647},
    #     ]
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, 1)

      data = data.sort_by_hash_date_time_asc

      nvi_cumulative = 1_000.00
      output = []
      prev_price = data.shift

      output << { date_time: prev_price[:date_time], value: nvi_cumulative } # Start with default of 1_000

      data.each do |v|
        volume_change = ((v[:volume] - prev_price[:volume]) / prev_price[:volume])

        if volume_change < 0
          price_change = ((v[:close] - prev_price[:close]) / prev_price[:close]) * 100.00
          nvi_cumulative += price_change
        end

        output << { date_time: v[:date_time], value: nvi_cumulative }
        prev_price = v
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
