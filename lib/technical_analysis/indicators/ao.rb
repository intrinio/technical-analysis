module TechnicalAnalysis
  class Ao < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "ao"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Awesome Oscillator"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(short_period long_period)
    end

    # Validates the provided options for this technical indicator
    #
    # @param options [Hash] The options for the technical indicator to be validated
    #
    # @return [Boolean] Returns true if options are valid or raises a ValidationError if they're not
    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    # Calculates the minimum number of observations needed to calculate the technical indicator
    #
    # @param options [Hash] The options for the technical indicator
    #
    # @return [Integer] Returns the minimum number of observations needed to calculate the technical
    #    indicator based on the options provided
    def self.min_data_size(long_period: 34, **params)
      long_period.to_i
    end

    # Calculates the awesome oscillator for the data over the given period
    # https://www.tradingview.com/wiki/Awesome_Oscillator_(AO)
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low)
    # @param short_period [Integer] The given period to calculate the short period SMA
    # @param long_period [Integer] The given period to calculate the long period SMA
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => -17.518757058823525},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => -17.8071908823529},
    #     ]
    def self.calculate(data, short_period: 5, long_period: 34)
      short_period = short_period.to_i
      long_period = long_period.to_i
      Validation.validate_numeric_data(data, :high, :low)
      Validation.validate_length(data, long_period)

      data = data.sort_by_hash_date_time_asc

      midpoint_values = []
      output = []

      data.each do |v|
        midpoint = (v[:high] + v[:low]) / 2
        midpoint_values << midpoint

        if midpoint_values.size == long_period
          short_period_sma = midpoint_values.last(short_period).average
          long_period_sma = midpoint_values.average
          value = short_period_sma - long_period_sma

          output << { date_time: v[:date_time], value: value }

          midpoint_values.shift
        end
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
