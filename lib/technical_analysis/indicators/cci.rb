module TechnicalAnalysis
  class Cci < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "cci"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Commodity Channel Index"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period constant)
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
    #   indicator based on the options provided
    def self.min_data_size(period: 20, **params)
      period.to_i
    end

    # Calculates the commodity channel index (CCI) for the data over the given period
    # https://en.wikipedia.org/wiki/Commodity_channel_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the CCI
    # @param constant [Float] The given constant to ensure that approximately 70 to 80 percent of
    #   CCI values would fall between −100 and +100
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => -48.14847062019609},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => -72.7408611895969},
    #     ]
    def self.calculate(data, period: 20, constant: 0.015)
      period = period.to_i
      constant = constant.to_f
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period))

      data = data.sort_by_date_time_asc

      output = []
      typical_prices = []

      data.each do |v|
        typical_price = StockCalculation.typical_price(v)
        typical_prices << typical_price

        if typical_prices.size == period
          period_sma = typical_prices.average
          mean_deviation = typical_prices.map { |tp| (tp - period_sma).abs }.mean
          cci = (typical_price - period_sma) / (constant * mean_deviation)

          output << { date_time: v[:date_time], value: cci }
          typical_prices.shift
        end
      end

      output.sort_by_date_time_desc
    end

  end
end
