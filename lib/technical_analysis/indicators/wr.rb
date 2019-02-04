module TechnicalAnalysis
  class Wr < Indicator

    def self.indicator_symbol
      "wr"
    end

    def self.indicator_name
      "Williams %R"
    end

    def self.valid_options
      %i(period)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(period: 14)
      period.to_i
    end

    # Calculates the Williams %R (WR) for the data over the given period
    # https://en.wikipedia.org/wiki/Williams_%25R
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given look-back period to calculate the WR
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        period_values << { high: v[:high], low: v[:low] }

        if period_values.size == period
          lowest_low = period_values.map { |pv| pv[:low] }.min
          highest_high = period_values.map { |pv| pv[:high] }.max

          wr = (highest_high - v[:close]) / (highest_high - lowest_low) * -100

          output << { date_time: v[:date_time], value: wr }

          period_values.shift
        end
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
