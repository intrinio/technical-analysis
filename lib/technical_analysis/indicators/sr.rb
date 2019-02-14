module TechnicalAnalysis
  # Stochastic Oscillator
  class Sr < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "sr"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Stochastic Oscillator"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period signal_period)
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
    def self.min_data_size(period: 14, signal_period: 3)
      period.to_i + signal_period.to_i - 1
    end

    # Calculates the stochastic oscillator (%K) for the data over the given period
    # https://en.wikipedia.org/wiki/Stochastic_oscillator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the SR
    # @param signal_period [Integer] The given period to calculate the SMA as a signal line for SR
    #
    # @return [Array<SrValue>] An array of SrValue instances
    def self.calculate(data, period: 14, signal_period: 3)
      period = period.to_i
      signal_period = signal_period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period, signal_period: signal_period))

      data = data.sort_by_date_time_asc

      high_low_values = []
      output = []
      sr_values = []

      data.each do |v|
        high_low_values << { high: v[:high], low: v[:low] }

        if high_low_values.size == period
          lowest_low = high_low_values.map { |hlv| hlv[:low] }.min
          highest_high = high_low_values.map { |hlv| hlv[:high] }.max

          sr = (v[:close] - lowest_low) / (highest_high - lowest_low) * 100.00

          sr_values << sr

          if sr_values.size == signal_period
            signal = sr_values.average

            output << SrValue.new(
              date_time: v[:date_time],
              sr: sr,
              sr_signal: signal
            )

            sr_values.shift
          end

          high_low_values.shift
        end
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class SrValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the sr calculation value
    attr_accessor :sr

    # @return [Float] the sr_signal calculation value
    attr_accessor :sr_signal

    def initialize(date_time: nil, sr: nil, sr_signal: nil)
      @date_time = date_time
      @sr = sr
      @sr_signal = sr_signal
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, sr: @sr, sr_signal: @sr_signal }
    end

  end
end
