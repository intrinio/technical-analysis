module TechnicalAnalysis
  class Adtv < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "adtv"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Average Daily Trading Volume"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period volume_key)
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
    def self.min_data_size(period: 22, **params)
      period.to_i
    end

    # Calculates the average daily trading volume (ADTV) for the data over the given period
    # https://www.investopedia.com/terms/a/averagedailytradingvolume.asp
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given number of days used to calculate the ADTV
    # @param volume_key [Symbol] The hash key for the volume data. Default :value
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => 49513676.36363637},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => 49407791.81818182},
    #     ]
    def self.calculate(data, period: 22, volume_key: :value)
      period = period.to_i
      volume_key = volume_key.to_sym
      Validation.validate_numeric_data(data, volume_key)
      Validation.validate_length(data, min_data_size(period: period))

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        period_values << v[volume_key]
        if period_values.size == period
          output << { date_time: v[:date_time], value: period_values.average }
          period_values.shift
        end
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
