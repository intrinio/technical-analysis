module TechnicalAnalysis
  class Mfi < Indicator

    def self.indicator_symbol
      "mfi"
    end

    def self.indicator_name
      "Money Flow Index"
    end

    def self.valid_options
      %i(period)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(period: 14)
      period.to_i + 1
    end

    # Calculates the money flow index (MFI) for the data over the given period
    # https://en.wikipedia.org/wiki/Money_flow_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close, :volume)
    # @param period [Integer] The given period to calculate the MFI
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close, :volume)
      Validation.validate_length(data, period + 1)

      data = data.sort_by_hash_date_time_asc

      output = []
      prev_typical_price = StockCalculation.typical_price(data.first)
      raw_money_flows = []

      data.shift

      data.each do |v|
        typical_price = StockCalculation.typical_price(v)

        if typical_price < prev_typical_price
          money_flow = (-1.0 * typical_price * v[:volume])
        elsif typical_price > prev_typical_price
          money_flow = (typical_price * v[:volume])
        else
          money_flow = 0.0
        end

        raw_money_flows << money_flow

        if raw_money_flows.size == period
          positive_period_flows = raw_money_flows.map { |rmf| rmf.positive? ? rmf : 0 }.sum
          negative_period_flows = raw_money_flows.map { |rmf| rmf.negative? ? rmf.abs : 0 }.sum

          money_flow_ratio = (positive_period_flows / negative_period_flows)
          mfi = (100.00 - (100.00 / (1.0 + money_flow_ratio)))

          output << { date_time: v[:date_time], value: mfi }

          raw_money_flows.shift
        end

        prev_typical_price = typical_price
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
