module TechnicalAnalysis
  # Ultimate Oscillator
  class Uo < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "uo"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Ultimate Oscillator"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(short_period medium_period long_period short_weight medium_weight long_weight)
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
    def self.min_data_size(long_period: 28, **params)
      long_period.to_i + 1
    end

    # Calculates the ultimate oscillator (UO) for the data over the given period
    # https://en.wikipedia.org/wiki/Ultimate_oscillator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param short_period [Integer] The given short period 
    # @param medium_period [Integer] The given medium period 
    # @param long_period [Integer] The given long period 
    # @param short_weight [Float] Weight of short Buying Pressure average for UO
    # @param medium_weight [Float] Weight of medium Buying Pressure average for UO
    # @param long_weight [Float] Weight of long Buying Pressure average for UO
    #
    # @return [Array<UoValue>] An array of UoValue instances
    def self.calculate(data, short_period: 7, medium_period: 14, long_period: 28, short_weight: 4, medium_weight: 2, long_weight: 1)
      short_period = short_period.to_i
      medium_period = medium_period.to_i
      long_period = long_period.to_i
      short_weight = short_weight.to_f
      medium_weight = medium_weight.to_f
      long_weight = long_weight.to_f
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(long_period: long_period))
      Validation.validate_date_time_key(data)

      data = data.sort_by_date_time_asc

      output = []
      period_values = []
      prior_close = data.shift[:close]
      sum_of_weights = [short_weight, medium_weight, long_weight].sum

      data.each do |v|
        min_low_p_close = [v[:low], prior_close].min
        max_high_p_close = [v[:high], prior_close].max

        buying_pressure = v[:close] - min_low_p_close
        true_range = max_high_p_close - min_low_p_close

        period_values << { buying_pressure: buying_pressure, true_range: true_range }

        if period_values.size == long_period
          short_average = calculate_average(short_period, period_values)
          medium_average = calculate_average(medium_period, period_values)
          long_average = calculate_average(long_period, period_values)
          uo = 100 * (((short_weight * short_average) + (medium_weight * medium_average) + (long_weight * long_average)) / (sum_of_weights))

          output << UoValue.new(date_time: v[:date_time], uo: uo)

          period_values.shift
        end

        prior_close = v[:close]
      end

      output.sort_by_date_time_desc
    end

    private_class_method def self.calculate_average(period, data)
      buying_pressures_sum = data.last(period).map { |d| d[:buying_pressure] }.sum
      true_ranges_sum = data.last(period).map { |d| d[:true_range] }.sum

      buying_pressures_sum / true_ranges_sum
    end

  end

  # The value class to be returned by calculations
  class UoValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the uo calculation value
    attr_accessor :uo

    def initialize(date_time: nil, uo: nil)
      @date_time = date_time
      @uo = uo
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, uo: @uo }
    end

  end
end
