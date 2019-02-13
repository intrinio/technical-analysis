module TechnicalAnalysis
  class Bb < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "bb"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Bollinger Bands"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period standard_deviations price_key)
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
      period.to_i
    end

    # Calculates the bollinger bands (BB) for the data over the given period
    # https://en.wikipedia.org/wiki/Bollinger_Bands
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the BB
    # @param standard_deviations [Float] The given standard deviations to calculate the upper and lower bands of the BB
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {
    #         :date_time => "2019-01-09T00:00:00.000Z",
    #         :value => {
    #           :lower_band  => 141.02036711220762,
    #           :middle_band => 157.35499999999996,
    #           :upper_band  => 173.6896328877923
    #         }
    #       },
    #       {
    #         :date_time => "2019-01-08T00:00:00.000Z",
    #         :value=> {
    #           :lower_band  => 141.07714470666247,
    #           :middle_band => 158.1695,
    #           :upper_band  => 175.26185529333753
    #         }
    #       },
    #     ]
    def self.calculate(data, period: 20, standard_deviations: 2, price_key: :value)
      period = period.to_i
      standard_deviations = standard_deviations.to_f
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size(period: period))

      data = data.sort_by_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        period_values << v[price_key]

        if period_values.size == period
          mb = period_values.average
          sd = period_values.standard_deviation
          ub = mb + standard_deviations * sd
          lb = mb - standard_deviations * sd

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

      output.sort_by_date_time_desc
    end

  end
end
