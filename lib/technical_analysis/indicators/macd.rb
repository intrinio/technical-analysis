module TechnicalAnalysis
  class Macd < Indicator

    def self.indicator_symbol
      "macd"
    end

    def self.indicator_name
      "Moving Average Convergence Divergence"
    end

    def self.valid_options
      %i(fast_period slow_period signal_period price_key)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(slow_period: 26, signal_period: 9, **params)
      slow_period.to_i + signal_period.to_i
    end

    # Calculates the moving average convergence divergence (MACD) for the data over the given period
    # https://en.wikipedia.org/wiki/MACD
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param fast_period [Integer] The given period to calculate the fast moving EMA for MACD
    # @param slow_period [Integer] The given period to calculate the slow moving EMA for MACD
    # @param signal_period [Integer] The given period to calculate the singal line for MACD
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, fast_period: 12, slow_period: 26, signal_period: 9, price_key: :value)
      fast_period = fast_period.to_i
      slow_period = slow_period.to_i
      signal_period = signal_period.to_i
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, slow_period + signal_period)

      data = data.sort_by_hash_date_time_asc

      macd_values = []
      output = []
      period_values = []
      prev_fast_ema = nil
      prev_signal = nil
      prev_slow_ema = nil

      data.each do |v|
        period_values << v[price_key]

        if period_values.size >= fast_period
          fast_ema = StockCalculation.ema(v[price_key], period_values, fast_period, prev_fast_ema)
          prev_fast_ema = fast_ema

          if period_values.size == slow_period
            slow_ema = StockCalculation.ema(v[price_key], period_values, slow_period, prev_slow_ema)
            prev_slow_ema = slow_ema

            macd = fast_ema - slow_ema
            macd_values << macd
            
            if macd_values.size == signal_period
              signal = StockCalculation.ema(macd, macd_values, signal_period, prev_signal)
              prev_signal = signal

              output << {
                date_time: v[:date_time],
                value: {
                  macd_line: macd,
                  signal_line: signal,
                  macd_histogram: macd - signal,
                }
              }

              macd_values.shift
            end

            period_values.shift
          end
        end
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
