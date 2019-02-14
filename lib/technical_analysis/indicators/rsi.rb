module TechnicalAnalysis
  # Relative Strength Index
  class Rsi < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "rsi"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Relative Strength Index"
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
    def self.min_data_size(period: 14, **params)
      period.to_i + 1
    end

    # Calculates the relative strength index for the data over the given period
    # https://en.wikipedia.org/wiki/Relative_strength_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the RSI
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<RsiValue>] An array of RsiValue instances
    def self.calculate(data, period: 14, price_key: :value)
      period = period.to_i
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size(period: period))

      data = data.sort_by_date_time_asc

      output = []
      prev_price = data.shift[price_key]
      prev_avg = nil
      price_changes = []
      smoothing_period = period - 1

      data.each do |v|
        price_change = (v[price_key] - prev_price)
        price_changes << price_change

        if price_changes.size == period
          if prev_avg.nil?
            avg_gain = price_changes.map { |pc| pc.positive? ? pc : 0 }.average
            avg_loss = price_changes.map { |pc| pc.negative? ? pc.abs : 0 }.average
          else
            if price_change > 0
              current_loss = 0
              current_gain = price_change
            elsif price_change < 0
              current_loss = price_change.abs
              current_gain = 0
            else
              current_loss = 0
              current_gain = 0
            end

            avg_gain = (((prev_avg[:gain] * smoothing_period) + current_gain) / period.to_f)
            avg_loss = (((prev_avg[:loss] * smoothing_period) + current_loss) / period.to_f)
          end

          if avg_loss == 0
            rsi = 100
          else
            rs = avg_gain / avg_loss
            rsi = (100.00 - (100.00 / (1.00 + rs)))
          end

          output << RsiValue.new(date_time: v[:date_time], rsi: rsi)

          prev_avg = { gain: avg_gain, loss: avg_loss }
          price_changes.shift
        end

        prev_price = v[price_key]
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class RsiValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the rsi calculation value
    attr_accessor :rsi

    def initialize(date_time: nil, rsi: nil)
      @date_time = date_time
      @rsi = rsi
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, rsi: @rsi }
    end

  end
end
