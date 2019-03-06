module TechnicalAnalysis
  # Force Index
  class Fi < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "fi"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Force Index"
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
    # @return [Boolean] Returns true if options are valid or raises a ValidationError if they're not
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
      2
    end

    # Calculates the force index (FI) for the data
    # https://en.wikipedia.org/wiki/Force_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :close, :volume)
    #
    # @return [Array<FiValue>] An array of FiValue instances
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, min_data_size({}))
      Validation.validate_date_time_key(data)

      data = data.sort_by_date_time_asc

      output = []
      prev_price = data.shift

      data.each do |v|
        fi = ((v[:close] - prev_price[:close]) * v[:volume])

        output << FiValue.new(date_time: v[:date_time], fi: fi)

        prev_price = v
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class FiValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the fi calculation value
    attr_accessor :fi

    def initialize(date_time: nil, fi: nil)
      @date_time = date_time
      @fi = fi
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, fi: @fi }
    end

  end
end
