module TechnicalAnalysis
  # Negative Volume Index
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
    # @return [Boolean] Returns true if options are valid or raises a ValidationError if they're not
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
    # @return [Array<NviValue>] An array of NviValue instances
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, min_data_size({}))

      data = data.sort_by_date_time_asc

      nvi_cumulative = 1_000.00
      output = []
      prev_price = data.shift

      output << NviValue.new(date_time: prev_price[:date_time], nvi: nvi_cumulative) # Start with default of 1_000

      data.each do |v|
        volume_change = ((v[:volume] - prev_price[:volume]) / prev_price[:volume])

        if volume_change < 0
          price_change = ((v[:close] - prev_price[:close]) / prev_price[:close]) * 100.00
          nvi_cumulative += price_change
        end

        output << NviValue.new(date_time: v[:date_time], nvi: nvi_cumulative)
        prev_price = v
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class NviValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the nvi calculation value
    attr_accessor :nvi

    def initialize(date_time: nil, nvi: nil)
      @date_time = date_time
      @nvi = nvi
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, nvi: @nvi }
    end

  end
end
