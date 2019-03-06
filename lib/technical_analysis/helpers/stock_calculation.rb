module TechnicalAnalysis
  class StockCalculation

    def self.true_range(current_high, current_low, previous_close)
      [
        (current_high - current_low),
        (current_high - previous_close).abs,
        (current_low - previous_close).abs
      ].max
    end

    def self.typical_price(price)
      (price[:high] + price[:low] + price[:close]) / 3.0
    end

    def self.ema(current_value, data, period, prev_value)
      if prev_value.nil?
        ArrayHelper.average(data)
      else
        (current_value - prev_value) * (2.0 / (period + 1.0)) + prev_value
      end
    end

  end
end
