module TechnicalAnalysis
  class Adi < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "adi"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Accumulation/Distribution Index"
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

    # Calculates the Accumulation/Distribution Index (ADI) for the given data
    # https://en.wikipedia.org/wiki/Accumulation/distribution_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close, :volume)
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #      {:date_time => "2019-01-09T00:00:00.000Z", :value => -112451134.66006838},
    #      {:date_time => "2019-01-08T00:00:00.000Z", :value => -135060226.53761944},
    #     ]
    def self.calculate(data)
      Validation.validate_numeric_data(data, :high, :low, :close, :volume)

      data = data.sort_by_hash_date_time_asc

      ad = 0
      ads = []
      clv = 0
      prev_ad = 0

      data.each_with_index do |values, i|
        if values[:high] == values[:low]
          clv = 0
        else
          clv = ((values[:close] - values[:low]) - (values[:high] - values[:close])) / (values[:high] - values[:low])
        end

        ad = prev_ad + (clv * values[:volume])
        prev_ad = ad

        ads << { date_time: values[:date_time], value: ad }
      end
      ads.sort_by_hash_date_time_desc
    end

  end
end
