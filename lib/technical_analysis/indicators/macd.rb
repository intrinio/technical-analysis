module TechnicalAnalysis
  class Macd

    # Calculates the moving average convergence divergence (MACD) for the data over the given period
    # https://en.wikipedia.org/wiki/MACD
    # 
    # @param data [Array] Array of hashes with keys (:date, :value)
    # @param fast_period [Integer] The given period to calculate the fast moving EMA for MACD
    # @param slow_period [Integer] The given period to calculate the slow moving EMA for MACD
    # @param signal_period [Integer] The given period to calculate the singal line for MACD
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, fast_period: 12, slow_period: 26, signal_period: 9, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, slow_period + signal_period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      prev_fast_ema = nil
      prev_signal = nil
      prev_slow_ema = nil
      macd_values = []
      output = []
      period_values = []

      data.each do |v|
        period_values << v[price_key]

        if period_values.size >= fast_period
          if prev_fast_ema.nil?
            fast_ema = period_values.last(fast_period).average
          else
            fast_ema = (v[price_key] - prev_fast_ema) * (2.0 / (fast_period + 1.0)) + prev_fast_ema
          end

          prev_fast_ema = fast_ema

          if period_values.size == slow_period
            if prev_slow_ema.nil?
              slow_ema = period_values.average
            else
              slow_ema = (v[price_key] - prev_slow_ema) * (2.0 / (slow_period + 1.0)) + prev_slow_ema
            end

            prev_slow_ema = slow_ema

            macd = fast_ema - slow_ema
            macd_values << macd
            
            if macd_values.size == signal_period
              if prev_signal.nil?
                signal = macd_values.average
              else
                signal = (macd - prev_signal) * (2.0 / (signal_period + 1.0)) + prev_signal
              end

              prev_signal = signal

              output << {
                date: v[:date],
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

      output
    end

  end
end
