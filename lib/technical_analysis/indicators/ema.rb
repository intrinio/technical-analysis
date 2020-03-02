module TechnicalAnalysis
  # Exponential Moving Average
  class Ema < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "ema"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Exponential Moving Average"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period price_key date_time_key)
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
    def self.min_data_size(period: 30, **params)
      period.to_i
    end

    # Calculates the exponential moving average (EMA) for the data over the given period
    # https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the EMA
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @param date_time_key [Symbol] The hash key for the date time data. Default :date_time
    #
    # @return [Array<EmaValue>] An array of EmaValue instances
    def self.calculate(data, period: 30, price_key: :value, date_time_key: :date_time)
      period = period.to_i
      price_key = price_key.to_sym
      date_time_key = date_time_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size(period: period))
      Validation.validate_date_time_key(data, date_time_key)

      data = data.sort_by { |row| row[date_time_key] }

      output = []
      period_values = []
      previous_ema = nil

      data.each do |v|
        period_values << v[price_key]
        if period_values.size == period
          ema = StockCalculation.ema(v[price_key], period_values, period, previous_ema)
          previous_ema = ema

          output << EmaValue.new(date_time: v[date_time_key], ema: ema)
          period_values.shift
        end
      end

      output.sort_by(&:date_time).reverse
    end

  end

  # The value class to be returned by calculations
  class EmaValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the ema calculation value
    attr_accessor :ema

    def initialize(date_time: nil, ema: nil)
      @date_time = date_time
      @ema = ema
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, ema: @ema }
    end
  end
end
