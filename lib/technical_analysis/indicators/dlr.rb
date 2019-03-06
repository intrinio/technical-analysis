module TechnicalAnalysis
  # Daily Log Return
  class Dlr < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "dlr"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Daily Log Return"
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

    # Calculates the daily log return (percent expressed as a decimal) for the data over the given period
    # https://www.quora.com/What-are-daily-log-returns-of-an-equity
    # https://en.wikipedia.org/wiki/Rate_of_return#Logarithmic_or_continuously_compounded_return
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<DlrValue>] An array of DlrValue instances
    def self.calculate(data, price_key: :value)
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, min_data_size({}))
      Validation.validate_date_time_key(data)

      data = data.sort_by_date_time_asc

      output = []
      prev_price = data.first[price_key].to_f

      data.each do |v|
        current_price = v[:close].to_f

        output << DlrValue.new(date_time: v[:date_time], dlr: Math.log(current_price / prev_price))

        prev_price = current_price
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class DlrValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the dlr calculation value
    attr_accessor :dlr

    def initialize(date_time: nil, dlr: nil)
      @date_time = date_time
      @dlr = dlr
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, dlr: @dlr }
    end

  end
end
