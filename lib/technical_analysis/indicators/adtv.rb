module TechnicalAnalysis
  # Average Daily Trading Volume
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
    # @return [Array<AdtvValue>] An array of AdtvValue instances
    def self.calculate(data, period: 22, volume_key: :value)
      period = period.to_i
      volume_key = volume_key.to_sym
      Validation.validate_numeric_data(data, volume_key)
      Validation.validate_length(data, min_data_size(period: period))
      Validation.validate_date_time_key(data)

      data = data.sort_by_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        period_values << v[volume_key]
        if period_values.size == period
          output << AdtvValue.new(date_time: v[:date_time], adtv: period_values.average)
          period_values.shift
        end
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class AdtvValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the adtv calculation value
    attr_accessor :adtv

    def initialize(date_time: nil, adtv: nil)
      @date_time = date_time
      @adtv = adtv
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, adtv: @adtv }
    end

  end
end
