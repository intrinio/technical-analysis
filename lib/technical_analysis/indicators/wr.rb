module TechnicalAnalysis
  # Williams %R
  class Wr < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "wr"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Williams %R"
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
    def self.min_data_size(period: 14)
      period.to_i
    end

    # Calculates the Williams %R (WR) for the data over the given period
    # https://en.wikipedia.org/wiki/Williams_%25R
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given look-back period to calculate the WR
    #
    # @return [Array<WrValue>] An array of WrValue instances
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period))
      Validation.validate_date_time_key(data)

      data = data.sort_by_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        period_values << { high: v[:high], low: v[:low] }

        if period_values.size == period
          lowest_low = period_values.map { |pv| pv[:low] }.min
          highest_high = period_values.map { |pv| pv[:high] }.max

          wr = (highest_high - v[:close]) / (highest_high - lowest_low) * -100

          output << WrValue.new(date_time: v[:date_time], wr: wr)

          period_values.shift
        end
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class WrValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the wr calculation value
    attr_accessor :wr

    def initialize(date_time: nil, wr: nil)
      @date_time = date_time
      @wr = wr
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, wr: @wr }
    end

  end
end
