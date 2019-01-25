module TechnicalAnalysis
  class Mfi

    # Calculates the money flow index (MFI) for the data over the given period
    # https://en.wikipedia.org/wiki/Money_flow_index
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :close, :volume)
    # @param period [Integer] The given period to calculate the MFI
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data, period: 14)
      Validation.validate_numeric_data(data, :high, :low, :close, :volume)
      Validation.validate_length(data, period + 1)

      data = data.sort_by_hash_date_asc # Sort data by descending dates

      output = []
      raw_money_flows = []
      prev_typical_price = calc_typical_price(data.first)

      data.shift

      data.each do |v|
        typical_price = calc_typical_price(v)

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

          output << { date: v[:date], value: mfi }

          raw_money_flows.shift
        end

        prev_typical_price = typical_price
      end

      output
    end

    def self.calc_typical_price(price)
      ((price[:high] + price[:low] + price[:close]) / 3).to_f
    end

  end
end
