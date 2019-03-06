module TechnicalAnalysis
  # Awesome Oscillator
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
    # @return [Array<AoValue>] An array of AoValue instances
    def self.calculate(data, short_period: 5, long_period: 34)
      short_period = short_period.to_i
      long_period = long_period.to_i
      Validation.validate_numeric_data(data, :high, :low)
      Validation.validate_length(data, min_data_size(long_period: long_period))
      Validation.validate_date_time_key(data)

      data = data.sort_by { |row| row[:date_time] }

      midpoint_values = []
      output = []

      data.each do |v|
        midpoint = (v[:high] + v[:low]) / 2
        midpoint_values << midpoint

        if midpoint_values.size == long_period
          short_period_sma = ArrayHelper.average(midpoint_values.last(short_period))
          long_period_sma = ArrayHelper.average(midpoint_values)
          value = short_period_sma - long_period_sma

          output << AoValue.new(date_time: v[:date_time], ao: value)

          midpoint_values.shift
        end
      end

      output.sort_by(&:date_time).reverse
    end

  end

  # The value class to be returned by calculations
  class AoValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the ao calculation value
    attr_accessor :ao

    def initialize(date_time: nil, ao: nil)
      @date_time = date_time
      @ao = ao
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, ao: @ao }
    end

  end
end
