module TechnicalAnalysis
  class SrSignal

    # Calculates the stochastic oscillator signal (%D) for the data over the given period
    # https://en.wikipedia.org/wiki/Stochastic_oscillator
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :close)
    # @param period [Integer] The given period to calculate the SR
    # @param sma_period [Integer] The given period to calculate the SMA over SR
    # @return [Array] Array of hashes with keys(:date, :value)
    def self.calculate(data, period: 14, sma_period: 3)
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      stochastic_oscillators = Sr.calculate(data, period: period)
      Sma.calculate(stochastic_oscillators, period: 3, price_key: :value)
    end

  end
end
