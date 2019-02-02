module TechnicalAnalysis
  class Sr < Indicator

    def self.indicator_symbol
      "sr"
    end

    def self.indicator_name
      "Stochastic Oscillator"
    end

    def self.valid_options
      %i(period signal_period)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(period: 14, signal_period: 3)
      period + signal_period - 1
    end

    # Calculates the stochastic oscillator (%K) for the data over the given period
    # https://en.wikipedia.org/wiki/Stochastic_oscillator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the SR
    # @return [Array] Array of hashes with keys(:date_time, :value)
    def self.calculate(data, period: 14, signal_period: 3)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period + signal_period - 1)

      data = data.sort_by_hash_date_time_asc

      high_low_values = []
      output = []
      sr_values = []

      data.each do |v|
        high_low_values << { high: v[:high], low: v[:low] }

        if high_low_values.size == period
          lowest_low = high_low_values.map { |hlv| hlv[:low] }.min
          highest_high = high_low_values.map { |hlv| hlv[:high] }.max

          sr = (v[:close] - lowest_low) / (highest_high - lowest_low) * 100.00

          sr_values << sr

          if sr_values.size == signal_period
            signal = sr_values.average

            output << {
              date_time: v[:date_time],
              value: {
                sr: sr,
                sr_signal: signal
              }
            }

            sr_values.shift
          end

          high_low_values.shift
        end
      end

      output
    end

  end
end
