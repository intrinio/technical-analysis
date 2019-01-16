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

      gains = []
      avg_gains_and_losses = []
      losses = []
      output = []
      prev_price = data.first[price_key].to_f
      price_changes = []
      smoothing_period = period - 1

      data.shift

      # Create new avg_gains_and_losses array of hashes with keys :date, :avg_gain, and :avg_loss
      # avg_gain - the average price gains over the last n periods, with smoothing
      # avg_loss - the average price loss over the last n periods, with smoothing
      data.each do |v|
        price_change = (v[price_key] - prev_price)
        price_changes << price_change

        if price_change >= 0
          gains << price_change.abs
          losses << 0.0
        else
          losses << price_change.abs
          gains << 0.0
        end

        if price_changes.size == period
          if avg_gains_and_losses.empty?
            avg_gain = gains.sum / period.to_f
            avg_loss = losses.sum / period.to_f
          else
            avg_gain = (((avg_gains_and_losses.last[:avg_gain] * smoothing_period) + gains.last) / period.to_f)
            avg_loss = (((avg_gains_and_losses.last[:avg_loss] * smoothing_period) + losses.last) / period.to_f)
          end

          avg_gains_and_losses << { date: v[:date], avg_gain: avg_gain, avg_loss: avg_loss }

          price_changes.shift
          gains.shift
          losses.shift
        end

        prev_price = v[price_key]
      end

      # Use avg_gains_and_losses array of hashes to calculate relative strength (RS) and
      # relative strength index (RSI) for output.
      # Only need to calculate using the last n period.
      avg_gains_and_losses = avg_gains_and_losses.last(period)

      avg_gains_and_losses.each do |v|
        if v[:avg_loss] == 0
          rsi = 100
        else
          rs = (v[:avg_gain].to_f / v[:avg_loss].to_f)
          rsi = (100.00 - (100.00 / (1.00 + rs)))
        end

        output << { date: v[:date], value: rsi }
      end

      output
    end

  end
end
