class Calculate

  def simple_moving_average(data, period: 30)
    # Validation    
    raise CalculateError.new "Not enough data for that period" if data.size < period

    output = {}
    period_values = []
    data = data.sort.to_h # Sort data by descending dates

    data.each do |date, price|
      period_values << price
      if period_values.size == period
        output[date] = sum_array(period_values) / period.to_f
        period_values.shift
      end
    end

    output
  end

  def sum_array(array)
    array.inject(0, :+)
  end

  class CalculateError < StandardError; end
end