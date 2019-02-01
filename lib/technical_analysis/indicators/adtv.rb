module TechnicalAnalysis
  class Adtv < Indicator

    def self.symbol
      "adtv"
    end

    # Calculates the average daily trading volume (ADTV) for the data over the given period
    # https://www.investopedia.com/terms/a/averagedailytradingvolume.asp
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given number of days used to calculate the ADTV
    # @param volume_key [Symbol] The hash key for the volume data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 22, volume_key: :value)
      Validation.validate_numeric_data(data, volume_key)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        period_values << v[volume_key]
        if period_values.size == period
          output << { date_time: v[:date_time], value: period_values.average }
          period_values.shift
        end
      end

      output
    end

  end
end
