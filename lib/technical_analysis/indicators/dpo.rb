module TechnicalAnalysis
  # Detrended Price Oscillator
  class Dpo < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "dpo"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Detrended Price Oscillator"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period price_key)
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
    def self.min_data_size(period: 20, **params)
      period.to_i + (period.to_i / 2)
    end

    # Calculates the detrended price oscillator for the data over the given period
    # https://en.wikipedia.org/wiki/Detrended_price_oscillator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the SMA
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<DpoValue>]
    def self.calculate(data, period: 20, price_key: :value)
      period = period.to_i
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size(period: period))

      data = data.sort_by_date_time_asc

      index = period + (period / 2) - 1
      midpoint_index = (period / 2) + 1
      output = []

      while index < data.size
        current_record = data[index]
        date_time = current_record[:date_time]
        current_price = current_record[price_key]

        sma_range = (index - midpoint_index - period + 2)..(index - midpoint_index + 1)
        midpoint_period_sma = data[sma_range].map { |v| v[price_key] }.average

        dpo = (current_price - midpoint_period_sma)

        output << DpoValue.new(date_time: date_time, dpo: dpo)

        index += 1
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class DpoValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the dpo calculation value
    attr_accessor :dpo

    def initialize(date_time: nil, dpo: nil)
      @date_time = date_time
      @dpo = dpo
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, dpo: @dpo }
    end

  end
end
