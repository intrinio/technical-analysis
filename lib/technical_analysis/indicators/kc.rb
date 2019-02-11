module TechnicalAnalysis
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
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {
    #         :date_time => "2019-01-09T00:00:00.000Z",
    #         :value => {
    #           :lower_band  => 147.1630066666667,
    #           :middle_band => 151.9909966666667,
    #           :upper_band  => 156.8189866666667
    #         }
    #       },
    #       {
    #         :date_time => "2019-01-08T00:00:00.000Z",
    #         :value => {
    #           :lower_band  => 146.74034,
    #           :middle_band => 151.57433,
    #           :upper_band  => 156.40832
    #         }
    #       }
    #     ]
    def self.calculate(data, period: 10)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period))

      data = data.sort_by_hash_date_time_asc

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

          output << {
            date_time: v[:date_time],
            value: {
              middle_band: mb,
              upper_band: ub,
              lower_band: lb
            }
          }

          period_values.shift
        end
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
