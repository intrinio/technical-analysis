module TechnicalAnalysis
  # Cumulative Return
  class Cr < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "cr"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Cumulative Return"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(price_key)
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
    def self.min_data_size(**params)
      1
    end

    # Calculates the cumulative return (CR) for the data over the given period
    # https://www.investopedia.com/terms/c/cumulativereturn.asp
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<CrValue>] An array of CrValue instances
    def self.calculate(data, price_key: :value)
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size({}))

      data = data.sort_by_date_time_asc

      output = []
      start_price = data.first[price_key] 

      data.each do |v|
        output << CrValue.new(
          date_time: v[:date_time],
          cr: ((v[price_key] - start_price) / start_price)
        )
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class CrValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the cr calculation value
    attr_accessor :cr

    def initialize(date_time: nil, cr: nil)
      @date_time = date_time
      @cr = cr
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, cr: @cr }
    end

  end
end
