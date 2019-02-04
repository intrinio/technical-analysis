module TechnicalAnalysis
  class Vi < Indicator

    def self.indicator_symbol
      "vi"
    end

    def self.indicator_name
      "Vortex Indicator"
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

    # Calculates the vortex indicator (VI) for the data over the given period
    # https://en.wikipedia.org/wiki/Vortex_indicator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the VI
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period + 1)

      data = data.sort_by_hash_date_time_asc

      output = []
      period_values = []
      prev_price = data.shift

      data.each do |v|
        positive_vm = (v[:high] - prev_price[:low]).abs
        negative_vm = (v[:low] - prev_price[:high]).abs
        tr = [(v[:high] - v[:low]), (v[:high] - prev_price[:close]).abs, (v[:low] - prev_price[:close]).abs].max

        period_values << { pos_vm: positive_vm, neg_vm: negative_vm, tr: tr }

        if period_values.size == period
          pos_vm_period = period_values.map { |pv| pv[:pos_vm] }.sum
          neg_vm_period = period_values.map { |pv| pv[:neg_vm] }.sum
          tr_period = period_values.map { |pv| pv[:tr] }.sum

          output << {
            date_time: v[:date_time],
            value: {
              positive_vi: (pos_vm_period / tr_period),
              negative_vi: (neg_vm_period / tr_period),
            }
          }

          period_values.shift
        end

        prev_price = v
      end

      output.sort_by_hash_date_time_desc
    end

  end
end
