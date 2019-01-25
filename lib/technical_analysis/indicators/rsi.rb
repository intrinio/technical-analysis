module TechnicalAnalysis
  class Rsi

    # Calculates the relative strength index for the data over the given period
    # https://en.wikipedia.org/wiki/Relative_strength_index
    # 
    # @param data [Array] Array of hashes with keys (:date, :value)
    # @param period [Integer] The given period to calculate the RSI
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 14, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, period + 1)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      output = []
      prev_price = data.shift[price_key]
      prev_avg = nil
      price_changes = []
      smoothing_period = period - 1

      data.each do |v|
        price_change = (v[price_key] - prev_price)
        price_changes << price_change

        if price_changes.size == period
          if prev_avg.nil?
            avg_gain = price_changes.map { |pc| pc.positive? ? pc : 0 }.sum / period.to_f
            avg_loss = price_changes.map { |pc| pc.negative? ? pc.abs : 0 }.sum / period.to_f
          else
            if price_change > 0
              current_loss = 0
              current_gain = price_change
            elsif price_change < 0
              current_loss = price_change.abs
              current_gain = 0
            else
              current_loss = 0
              current_gain = 0
            end

            avg_gain = (((prev_avg[:gain] * smoothing_period) + current_gain) / period.to_f)
            avg_loss = (((prev_avg[:loss] * smoothing_period) + current_loss) / period.to_f)
          end

          if avg_loss == 0
            rsi = 100
          else
            rs = avg_gain / avg_loss
            rsi = (100.00 - (100.00 / (1.00 + rs)))
          end

          output << { date: v[:date], value: rsi }

          prev_avg = { gain: avg_gain, loss: avg_loss }
          price_changes.shift
        end

        prev_price = v[price_key]
      end

      output
    end

  end
end
