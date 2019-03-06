module TechnicalAnalysis
  # Chaikin Money Flow
  class Cmf < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "cmf"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Chaikin Money Flow"
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
    def self.min_data_size(period: 20)
      period.to_i
    end

    # Calculates the chaikin money flow (CMF) for the data over the given period
    # https://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:chaikin_money_flow_cmf
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close, :volume)
    # @param period [Integer] The given period to calculate the CMF
    #
    # @return [Array<CmfValue>] An array of CmfValue instances
    def self.calculate(data, period: 20)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close, :volume)
      Validation.validate_length(data, min_data_size(period: period))
      Validation.validate_date_time_key(data)

      data = data.sort_by_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        multiplier = ((v[:close] - v[:low]) - (v[:high] - v[:close])) / (v[:high] - v[:low])
        mf_volume = multiplier * v[:volume]

        period_values << { volume: v[:volume], mf_volume: mf_volume }

        if period_values.size == period
          volume_sum = period_values.map { |pv| pv[:volume] }.sum
          mf_volume_sum = period_values.map { |pv| pv[:mf_volume] }.sum
          cmf = mf_volume_sum / volume_sum

          output << CmfValue.new(date_time: v[:date_time], cmf: cmf)

          period_values.shift
        end
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class CmfValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the cmf calculation value
    attr_accessor :cmf

    def initialize(date_time: nil, cmf: nil)
      @date_time = date_time
      @cmf = cmf
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, cmf: @cmf }
    end

  end
end
