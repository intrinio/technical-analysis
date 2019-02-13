module TechnicalAnalysis
  # Keltner Channel
  class Kc < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "kc"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Keltner Channel"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period)
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
    def self.min_data_size(period: 10)
      period.to_i
    end

    # Calculates the keltner channel (KC) for the data over the given period
    # https://en.wikipedia.org/wiki/Keltner_channel
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the KC
    #
    # @return [Array<KcValue>] An array of KcValue instances
    def self.calculate(data, period: 10)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period))

      data = data.sort_by_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        tp = StockCalculation.typical_price(v)
        tr = v[:high] - v[:low]
        period_values << { typical_price: tp, trading_range: tr }

        if period_values.size == period
          mb = period_values.map { |pv| pv[:typical_price] }.average

          trading_range_average = period_values.map { |pv| pv[:trading_range] }.average
          ub = mb + trading_range_average
          lb = mb - trading_range_average

          output << KcValue.new(
            date_time: v[:date_time],
            lower_band: lb,
            middle_band: mb,
            upper_band: ub
          )

          period_values.shift
        end
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class KcValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the lower_band calculation value
    attr_accessor :lower_band

    # @return [Float] the middle_band calculation value
    attr_accessor :middle_band

    # @return [Float] the upper_band calculation value
    attr_accessor :upper_band

    def initialize(date_time: nil, lower_band: nil, middle_band: nil, upper_band: nil)
      @date_time = date_time
      @lower_band = lower_band
      @middle_band = middle_band
      @upper_band = upper_band
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      {
        date_time: @date_time,
        lower_band: @lower_band,
        middle_band: @middle_band,
        upper_band: @upper_band
      }
    end

  end
end
