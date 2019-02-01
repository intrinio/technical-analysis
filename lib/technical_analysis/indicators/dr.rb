module TechnicalAnalysis
  class Dr < Indicator

    def self.indicator_symbol
      "dr"
    end

    def self.indicator_name
      "Daily Return"
    end

    def self.min_data_size(**params)
      1
    end

    # Calculates the daily return (percent expressed as a decimal) for the data over the given period
    # https://en.wikipedia.org/wiki/Rate_of_return
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, 1)

      data = data.sort_by_hash_date_time_asc

      output = []
      prev_price = data.first[price_key].to_f

      data.each do |v|
        current_price = v[:close].to_f

        output << { date_time: v[:date_time], value: ((current_price / prev_price) - 1) }

        prev_price = current_price
      end

      output
    end

  end
end
