module TechnicalAnalysis
  class Uo < Indicator

    def self.indicator_symbol
      "uo"
    end

    def self.indicator_name
      "Ultimate Oscillator"
    end

    def self.valid_options
      %i(short_period medium_period long_period short_weight medium_weight long_weight)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(long_period: 28, **params)
      long_period + 1
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
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, short_period: 7, medium_period: 14, long_period: 28, short_weight: 4, medium_weight: 2, long_weight: 1)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, long_period + 1)

      data = data.sort_by_hash_date_time_asc

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

          output << { date_time: v[:date_time], value: uo }

          period_values.shift
        end

        prior_close = v[:close]
      end

      output
    end

    def self.calculate_average(period, data)
      buying_pressures_sum = data.last(period).map { |d| d[:buying_pressure] }.sum
      true_ranges_sum = data.last(period).map { |d| d[:true_range] }.sum

      buying_pressures_sum / true_ranges_sum
    end

  end
end
