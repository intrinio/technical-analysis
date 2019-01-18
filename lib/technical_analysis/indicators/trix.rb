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
      multiplier = (2.0 / (period + 1.0))
      output = []
      period_values = []
      prev_ema_3 = nil

      data.each do |v|
        price = v[price_key]
        period_values << price

        if period_values.size == period
          if ema1.empty?
            ema1 << period_values.sum / period.to_f
          else
            last_ema1 = ema1.last
            ema_1 = ((multiplier * (price - last_ema1)) + last_ema1)
            ema1 << ema_1

            if ema1.size == period
              if ema2.empty?
                ema2 << ema1.sum / period.to_f
              else
                last_ema2 = ema2.last
                ema_2 = ((multiplier * (ema_1 - last_ema2)) + last_ema2)
                ema2 << ema_2

                if ema2.size == period
                  if prev_ema_3.nil?
                    prev_ema_3 = ema2.sum / period.to_f
                  else
                    ema_3 = ((multiplier * (ema_2 - prev_ema_3)) + prev_ema_3)

                    trix = ((ema_3 - prev_ema_3) / prev_ema_3)
                    output << { date: v[:date], value: trix }
                    prev_ema_3 = ema_3
                  end

                  ema2.shift
                end
              end

              ema1.shift
            end
          end

          period_values.shift
        end
      end

      output
    end

  end
end
