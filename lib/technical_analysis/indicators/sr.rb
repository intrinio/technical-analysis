module TechnicalAnalysis
  class Sr < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "sr"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Stochastic Oscillator"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period signal_period)
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
    def self.min_data_size(period: 14, signal_period: 3)
      period.to_i + signal_period.to_i - 1
    end

    # Calculates the stochastic oscillator (%K) for the data over the given period
    # https://en.wikipedia.org/wiki/Stochastic_oscillator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the SR
    # @param signal_period [Integer] The given period to calculate the SMA as a signal line for SR
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {
    #         :date_time => "2019-01-09T00:00:00.000Z",
    #         :value => {
    #           :sr => 44.44007858546172,
    #           :sr_signal => 33.739408752366685
    #         }
    #       },
    #       {
    #         :date_time => "2019-01-08T00:00:00.000Z",
    #         :value => {
    #           :sr => 34.27340383862123,
    #           :sr_signal => 26.631612985573174
    #         }
    #       },
    #     ]
    def self.calculate(data, period: 14, signal_period: 3)
      period = period.to_i
      signal_period = signal_period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period, signal_period: signal_period))

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

      output.sort_by_hash_date_time_desc
    end

  end
end
