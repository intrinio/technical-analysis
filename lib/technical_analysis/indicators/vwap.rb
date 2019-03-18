module TechnicalAnalysis
  # Volume Weighted Average Price
  class Vwap < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "vwap"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Volume Weighted Average Price"
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
      1
    end

    # Calculates the volume weighted average price (VWAP) for the data
    # https://en.wikipedia.org/wiki/Volume-weighted_average_price
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close, :volume)
    #
    # @return [Array<VwapValue>] An array of VwapValue instances
    def self.calculate(data)
      Validation.validate_numeric_data(data, :high, :low, :close, :volume)
      Validation.validate_length(data, min_data_size)
      Validation.validate_date_time_key(data)

      data = data.sort_by { |row| row[:date_time] }

      output = []
      cumm_volume = 0
      cumm_volume_x_typical_price = 0

      data.each do |v|
        typical_price = StockCalculation.typical_price(v)
        cumm_volume_x_typical_price += v[:volume] * typical_price
        cumm_volume += v[:volume]
        vwap = cumm_volume_x_typical_price.to_f / cumm_volume.to_f

        output << VwapValue.new(date_time: v[:date_time], vwap: vwap)
      end

      output.sort_by(&:date_time).reverse
    end

  end

  # The value class to be returned by calculations
  class VwapValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the vwap calculation value
    attr_accessor :vwap

    def initialize(date_time: nil, vwap: nil)
      @date_time = date_time
      @vwap = vwap
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, vwap: @vwap }
    end

  end
end
