module TechnicalAnalysis
  class Adtv

    # Calculates the average daily trading volume (ADTV) for the data over the given period
    # https://www.investopedia.com/terms/a/averagedailytradingvolume.asp
    # 
    # @param data [Array] Array of hashes with keys (:date, :value)
    # @param period [Integer] The given number of days used to calculate the ADTV
    # @param volume_key [Symbol] The hash key for the volume data. Default :value
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 22, volume_key: :value)
      Validation.validate_numeric_data(data, volume_key)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      output = []
      period_values = []

      data.each do |v|
        period_values << v[volume_key]
        if period_values.size == period
          output << { date: v[:date], value: period_values.sum / period.to_f }
          period_values.shift
        end
      end

      output
    end

  end
end
