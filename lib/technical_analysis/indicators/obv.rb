module TechnicalAnalysis
  class Obv < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "obv"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "On-balance Volume"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      []
    end

    # Validates the provided options for this technical indicator
    #
    # @param options [Hash] The options for the technical indicator to be validated
    #
    # @return [Boolean] Returns true if options vare valid or raises an error if they're not
    def self.validate_options(options)
      return true if options == {}
      raise Validation::ValidationError.new "This indicator doesn't accept any options."
    end

    # Calculates the minimum number of observations needed to calculate the technical indicator
    #
    # @param options [Hash] The options for the technical indicator
    #
    # @return [Integer] Returns the minimum number of observations needed to calculate the technical
    #    indicator based on the options provided
    def self.min_data_size(**params)
      1
    end

    # Calculates the on-balance volume (OBV) for the data over the given period
    # https://en.wikipedia.org/wiki/On-balance_volume
    #
    # @param data [Array] Array of hashes with keys (:date_time, :close, :volume)
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => -591085010},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => -636119380},
    #     ]
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, 1)

      data = data.sort_by_hash_date_time_asc

      current_obv = 0
      output = []
      prior_close = nil
      prior_volume = nil

      data.each do |v|
        volume = v[:volume]
        close = v[:close]

        unless prior_close.nil?
          current_obv += volume if close > prior_close
          current_obv -= volume if close < prior_close
        end

        output << { date_time: v[:date_time], value: current_obv }

        prior_volume = volume
        prior_close = close
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
