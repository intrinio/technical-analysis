module TechnicalAnalysis
  class Sr

    # Calculates the stochastic oscillator (%K) for the data over the given period
    # https://en.wikipedia.org/wiki/Stochastic_oscillator
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :close)
    # @param period [Integer] The given period to calculate the SR
    # @return [Array] Array of hashes with keys(:date, :value)
    def self.calculate(data, period: 14, signal_period: 3)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      high_values = []
      low_values = []
      output = []
      sr_values = []

      data.each do |v|
        high_values << v[:high]
        low_values << v[:low]

        if high_values.size == period && low_values.size == period
          lowest_low = low_values.min
          highest_high = high_values.max
          sr = (v[:close] - lowest_low) / (highest_high - lowest_low) * 100.00

          sr_values << sr
      
          if sr_values.size == signal_period
            signal = sr_values.sum / signal_period.to_f

            output << {
              date: v[:date],
              value: {
                sr: sr,
                sr_signal: signal
              }
            }

            sr_values.shift
          end

          low_values.shift
          high_values.shift
        end
      end

      output
    end

  end
end
