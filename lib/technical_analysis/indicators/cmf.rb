module TechnicalAnalysis
  class Cmf < Indicator

    def self.indicator_symbol
      "cmf"
    end

    def self.indicator_name
      "Chaikin Money Flow"
    end

    def self.valid_options
      %i(period)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(period: 20)
      period
    end

    # Calculates the chaikin money flow (CMF) for the data over the given period
    # https://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:chaikin_money_flow_cmf
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close, :volume)
    # @param period [Integer] The given period to calculate the CMF
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 20)
      Validation.validate_numeric_data(data, :high, :low, :close, :volume)
      Validation.validate_length(data, period)

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []

      data.each do |v|
        multiplier = ((v[:close] - v[:low]) - (v[:high] - v[:close])) / (v[:high] - v[:low])
        mf_volume = multiplier * v[:volume]

        period_values << { volume: v[:volume], mf_volume: mf_volume }

        if period_values.size == period
          volume_sum = period_values.map { |pv| pv[:volume] }.sum
          mf_volume_sum = period_values.map { |pv| pv[:mf_volume] }.sum
          cmf = mf_volume_sum / volume_sum

          output << { date_time: v[:date_time], value: cmf }
          period_values.shift
        end
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
