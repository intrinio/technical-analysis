module TechnicalAnalysis
  # Triple Exponential Average
  class Trix < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "trix"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Triple Exponential Average"
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
    def self.min_data_size(period: 15, **params)
      (period.to_i * 3) - 1
    end

    # Calculates the triple exponential average (Trix) for the data over the given period
    # https://en.wikipedia.org/wiki/Trix_(technical_analysis)
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the EMA for Trix
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<TrixValue>] An array of TrixValue instances
    def self.calculate(data, period: 15, price_key: :value)
      period = period.to_i
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size(period: period))
      Validation.validate_date_time_key(data)

      data = data.sort_by { |row| row[:date_time] }

      ema1 = []
      ema2 = []
      ema3 = []
      output = []
      period_values = []

      data.each do |v|
        price = v[price_key]
        period_values << price

        if period_values.size == period
          ema1_value = StockCalculation.ema(price, period_values, period, ema1.last)
          ema1 << ema1_value

          if ema1.size == period
            ema2_value = StockCalculation.ema(ema1_value, ema1, period, ema2.last)
            ema2 << ema2_value

            if ema2.size == period
              ema3_value = StockCalculation.ema(ema2_value, ema2, period, ema3.last)
              ema3 << ema3_value

              if ema3.size == 2
                prev_ema3, current_ema3 = ema3
                trix = ((current_ema3 - prev_ema3) / prev_ema3)
                output << TrixValue.new(date_time: v[:date_time], trix: trix)

                ema3.shift
              end

              ema2.shift
            end

            ema1.shift
          end

          period_values.shift
        end
      end

      output.sort_by(&:date_time).reverse
    end

  end

  # The value class to be returned by calculations
  class TrixValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the trix calculation value
    attr_accessor :trix

    def initialize(date_time: nil, trix: nil)
      @date_time = date_time
      @trix = trix
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, trix: @trix }
    end

  end
end
