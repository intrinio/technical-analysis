module TechnicalAnalysis
  class Trix < Indicator

    def self.indicator_symbol
      "trix"
    end

    def self.indicator_name
      "Triple Exponential Average"
    end

    def self.valid_options
      %i(period price_key)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(period: 15, **params)
      (period * 3) - 1
    end

    # Calculates the triple exponential average (Trix) for the data over the given period
    # https://en.wikipedia.org/wiki/Trix_(technical_analysis)
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the EMA for Trix
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 15, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, ((period * 3) - 1))

      data = data.sort_by_hash_date_time_asc

      ema1 = []
      ema2 = []
      ema3 = []
      output = []
      period_values = []

      data.each do |v|
        price = v[price_key]
        period_values << price

        if period_values.size == period
          ema1_value = StockCalculation.ema(price, period_values, period, ema1.last)
          ema1 << ema1_value

          if ema1.size == period
            ema2_value = StockCalculation.ema(ema1_value, ema1, period, ema2.last)
            ema2 << ema2_value

            if ema2.size == period
              ema3_value = StockCalculation.ema(ema2_value, ema2, period, ema3.last)
              ema3 << ema3_value

              if ema3.size == 2
                prev_ema3, current_ema3 = ema3
                trix = ((current_ema3 - prev_ema3) / prev_ema3)
                output << { date_time: v[:date_time], value: trix }

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

  end
end
