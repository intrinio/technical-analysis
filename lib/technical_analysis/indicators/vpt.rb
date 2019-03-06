module TechnicalAnalysis
  # Volume-price Trend
  class Vpt < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "vpt"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Volume-price Trend"
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

    # Calculates the volume-price trend (VPT) for the data
    # https://en.wikipedia.org/wiki/Volume%E2%80%93price_trend
    #
    # @param data [Array] Array of hashes with keys (:date_time, :close, :volume)
    #
    # @return [Array<VptValue>] An array of VptValue instances
    def self.calculate(data)
      Validation.validate_numeric_data(data, :close, :volume)
      Validation.validate_length(data, min_data_size({}))
      

      data = data.sort_by_date_time_asc

      output = []
      prev_price = data.shift
      prev_pvt = 0

      data.each do |v|
        pvt = prev_pvt + (((v[:close] - prev_price[:close]) / prev_price[:close]) * v[:volume])
        output << VptValue.new(date_time: v[:date_time], vpt: pvt)
        prev_price = v
        prev_pvt = pvt
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class VptValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the vpt calculation value
    attr_accessor :vpt

    def initialize(date_time: nil, vpt: nil)
      @date_time = date_time
      @vpt = vpt
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, vpt: @vpt }
    end

  end
end
