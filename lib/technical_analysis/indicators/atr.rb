module TechnicalAnalysis
  class Atr < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "atr"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Average True Range"
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
    def self.min_data_size(period: 14)
      period.to_i + 1
    end

    # Calculates the average true range (ATR) for the data over the given period
    # https://en.wikipedia.org/wiki/Average_true_range
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the ATR
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => 6.103013600253306},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => 6.195553107965099},
    #     ]
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period))

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []
      prev_price = data.shift

      data.each do |v|
        tr = StockCalculation.true_range(v[:high], v[:low], prev_price[:close])

        period_values << tr

        if period_values.size == period
          if output.empty?
            atr = period_values.average
          else
            atr = (output.last[:value] * (period - 1.0) + tr) / period.to_f
          end

          output << { date_time: v[:date_time], value: atr }

          period_values.shift
        end

        prev_price = v
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
