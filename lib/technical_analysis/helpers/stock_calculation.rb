class StockCalculation

  def self.true_range(current_high, current_low, previous_close)
    [
      (current_high - current_low),
      (current_high - previous_close).abs,
      (current_low - previous_close).abs
    ].max
  end

end
