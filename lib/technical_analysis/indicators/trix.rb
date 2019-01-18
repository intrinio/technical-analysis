module TechnicalAnalysis
  class Trix

    # Calculates the triple exponential average (Trix) for the data over the given period
    # https://en.wikipedia.org/wiki/Trix_(technical_analysis)
    # 
    # @param data [Array] Array of hashes with keys (:date, :value)
    # @param period [Integer] The given period to calculate the EMA for Trix
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 15, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, ((period * 3) - 1))

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      ema1 = []
      ema2 = []
      ema3 = []
      multiplier = (2.0 / (period + 1.0))
      output = []
      period_values = []

      data.each do |v|
        price = v[price_key]
        period_values << price

        if period_values.size == period
          ema1 = process_ema(price, period_values, multiplier, period, ema1)

          if ema1.size == period
            ema2 = process_ema(ema1.last, ema1, multiplier, period, ema2)

            if ema2.size == period
              ema3 = process_ema(ema2.last, ema2, multiplier, period, ema3)

              if ema3.size == 2
                prev_ema3, current_ema3 = ema3
                trix = ((current_ema3 - prev_ema3) / prev_ema3)
                output << { date: v[:date], value: trix }

                ema3.shift
              end

              ema2.shift
            end

            ema1.shift
          end

          period_values.shift
        end
      end

      output
    end

    def self.process_ema(current_value, data, multiplier, period, store)
      if store.empty?
        store << data.sum / period.to_f
      else
        prev_value = store.last
        store << ((multiplier * (current_value - prev_value)) + prev_value)
      end

      store
    end

  end
end
