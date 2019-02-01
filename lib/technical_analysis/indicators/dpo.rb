module TechnicalAnalysis
  class Dpo < Indicator

    def self.symbol
      "dpo"
    end

    # Calculates the detrended price oscillator for the data over the given period
    # https://en.wikipedia.org/wiki/Detrended_price_oscillator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the SMA
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 20, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, period + (period / 2))

      data = data.sort_by_hash_date_time_asc

      index = period + (period / 2) - 1
      midpoint_index = (period / 2) + 1
      output = []

      while index < data.size
        current_record = data[index]
        date_time = current_record[:date_time]
        current_price = current_record[price_key]

        sma_range = (index - midpoint_index - period + 2)..(index - midpoint_index + 1)
        midpoint_period_sma = data[sma_range].map { |v| v[price_key] }.average

        dop = (current_price - midpoint_period_sma)
      
        output << { date_time: date_time, value: dop }
        index += 1
      end

      output
    end

  end
end
