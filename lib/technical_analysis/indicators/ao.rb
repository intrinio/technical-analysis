module TechnicalAnalysis
  class Ao < Indicator

    def self.indicator_symbol
      "ao"
    end

    def self.indicator_name
      "Awesome Oscillator"
    end

    def self.valid_options
      %i(short_period long_period)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(long_period: 34, **params)
      long_period
    end

    # Calculates the awesome oscillator for the data over the given period
    # https://www.tradingview.com/wiki/Awesome_Oscillator_(AO)
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low)
    # @param short_period [Integer] The given period to calculate the short period SMA
    # @param long_period [Integer] The given period to calculate the long period SMA
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, short_period: 5, long_period: 34)
      Validation.validate_numeric_data(data, :high, :low)
      Validation.validate_length(data, long_period)

      data = data.sort_by_hash_date_time_asc

      midpoint_values = []
      output = []

      data.each do |v|
        midpoint = (v[:high] + v[:low]) / 2
        midpoint_values << midpoint

        if midpoint_values.size == long_period
          short_period_sma = midpoint_values.last(short_period).average
          long_period_sma = midpoint_values.average
          value = short_period_sma - long_period_sma

          output << { date_time: v[:date_time], value: value }

          midpoint_values.shift
        end
      end

      output
    end

  end
end
