module TechnicalAnalysis
  class Uo

    # Calculates the ultimate oscillator for the data over the given period
    # https://en.wikipedia.org/wiki/Ultimate_oscillator
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :close)
    # @param short_period [Integer] The given short period 
    # @param medium_period [Integer] The given medium period 
    # @param long_period [Integer] The given long period 
    # @param short_weight [Float] Weight of short Buying Pressure average for UO
    # @param medium_weight [Float] Weight of medium Buying Pressure average for UO
    # @param long_weight [Float] Weight of long Buying Pressure average for UO
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, short_period: 7, medium_period: 14, long_period: 28, short_weight: 4, medium_weight: 2, long_weight: 1)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, long_period + 1)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      prior_closes = []
      data.each { |v| prior_closes << v[:close] }

      formatted_data = []
      prior_closes.each_with_index do |prior_close, index|
        v = data[index + 1]
        unless v.nil?
          min_low_p_close = [v[:low], prior_close].min
          max_high_p_close = [v[:high], prior_close].max

          buying_pressure = v[:close] - min_low_p_close
          true_range = max_high_p_close - min_low_p_close

          formatted_data << {
            date: v[:date],
            buying_pressure: buying_pressure,
            true_range: true_range
          }
        end
      end

      buying_pressures = []
      output = []
      sum_of_weights = [short_weight, medium_weight, long_weight].sum
      true_ranges = []

      formatted_data.each do |v|
        buying_pressures << v[:buying_pressure]
        true_ranges << v[:true_range]

        if buying_pressures.size == long_period && true_ranges.size == long_period
          short_average = buying_pressures.last(short_period).sum / true_ranges.last(short_period).sum
          medium_average = buying_pressures.last(medium_period).sum / true_ranges.last(medium_period).sum
          long_average = buying_pressures.sum / true_ranges.sum

          uo = 100 * (((short_weight * short_average) + (medium_weight * medium_average) + (long_weight * long_average)) / (sum_of_weights))

          output << { date: v[:date], value: uo }
          buying_pressures.shift
          true_ranges.shift
        end
      end

      output
    end

  end
end
