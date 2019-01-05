module TechnicalAnalysis
  class Sma
    # Calculates the simple moving average for the data over the given period
    # https://en.wikipedia.org/wiki/Moving_average#Simple_moving_average
    # 
    # @param data [Hash] Date strings to price values
    # @param period [Integer] The given period to calculate the SMA
    # @return [Hash] A hash of date strings to SMA values
    def self.calculate(data, period: 30)
      Validation.validate_price_data(data)
      Validation.validate_length(data, period)
      
      output = {}
      period_values = []
      data = data.sort.to_h # Sort data by descending dates
      
      data.each do |date, price|
        period_values << price
        if period_values.size == period
          output[date] = period_values.sum / period.to_f
          period_values.shift
        end
      end

      output
    end
  end
end
