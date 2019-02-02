module TechnicalAnalysis
  class Kc < Indicator

    def self.indicator_symbol
      "kc"
    end

    def self.indicator_name
      "Keltner Channel"
    end

    def self.valid_options
      %i(period)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(period: 10)
      period
    end

    # Calculates the keltner channel (KC) for the data over the given period
    # https://en.wikipedia.org/wiki/Keltner_channel
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the KC
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 10)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        tp = StockCalculation.typical_price(v)
        tr = v[:high] - v[:low]
        period_values << { typical_price: tp, trading_range: tr }

        if period_values.size == period
          mb = period_values.map { |pv| pv[:typical_price] }.average

          trading_range_average = period_values.map { |pv| pv[:trading_range] }.average
          ub = mb + trading_range_average
          lb = mb - trading_range_average

          output << {
            date_time: v[:date_time],
            value: {
              middle_band: mb,
              upper_band: ub,
              lower_band: lb
            }
          }

          period_values.shift
        end
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
