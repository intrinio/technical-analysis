module TechnicalAnalysis
  # Moving Average Convergence Divergence
  class Macd < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "macd"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Moving Average Convergence Divergence"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(fast_period slow_period signal_period price_key)
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
    def self.min_data_size(slow_period: 26, signal_period: 9, **params)
      slow_period.to_i + signal_period.to_i - 1
    end

    # Calculates the moving average convergence divergence (MACD) for the data over the given period
    # https://en.wikipedia.org/wiki/MACD
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param fast_period [Integer] The given period to calculate the fast moving EMA for MACD
    # @param slow_period [Integer] The given period to calculate the slow moving EMA for MACD
    # @param signal_period [Integer] The given period to calculate the signal line for MACD
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<MacdValue>] An array of MacdValue instances
    def self.calculate(data, fast_period: 12, slow_period: 26, signal_period: 9, price_key: :value)
      fast_period = fast_period.to_i
      slow_period = slow_period.to_i
      signal_period = signal_period.to_i
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size(slow_period: slow_period, signal_period: signal_period))
      Validation.validate_date_time_key(data)

      data = data.sort_by_date_time_asc

      macd_values = []
      output = []
      period_values = []
      prev_fast_ema = nil
      prev_signal = nil
      prev_slow_ema = nil

      data.each do |v|
        period_values << v[price_key]

        if period_values.size >= fast_period
          fast_ema = StockCalculation.ema(v[price_key], period_values, fast_period, prev_fast_ema)
          prev_fast_ema = fast_ema

          if period_values.size == slow_period
            slow_ema = StockCalculation.ema(v[price_key], period_values, slow_period, prev_slow_ema)
            prev_slow_ema = slow_ema

            macd = fast_ema - slow_ema
            macd_values << macd
            
            if macd_values.size == signal_period
              signal = StockCalculation.ema(macd, macd_values, signal_period, prev_signal)
              prev_signal = signal

              output << MacdValue.new(
                date_time: v[:date_time],
                macd_line: macd,
                signal_line: signal,
                macd_histogram: macd - signal,
              )

              macd_values.shift
            end

            period_values.shift
          end
        end
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class MacdValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the macd_line calculation value
    attr_accessor :macd_line

    # @return [Float] the macd_histogram calculation value
    attr_accessor :macd_histogram

    # @return [Float] the signal_line calculation value
    attr_accessor :signal_line

    def initialize(date_time: nil, macd_line: nil, macd_histogram: nil, signal_line: nil)
      @date_time = date_time
      @macd_line = macd_line
      @macd_histogram = macd_histogram
      @signal_line = signal_line
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      {
        date_time: @date_time,
        macd_line: @macd_line,
        macd_histogram: @macd_histogram,
        signal_line: @signal_line
      }
    end

  end
end
