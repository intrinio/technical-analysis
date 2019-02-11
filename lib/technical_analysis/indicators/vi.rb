module TechnicalAnalysis
  class Vi < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "vi"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Vortex Indicator"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period)
    end

    # Validates the provided options for this technical indicator
    #
    # @param options [Hash] The options for the technical indicator to be validated
    #
    # @return [Boolean] Returns true if options are valid or raises a ValidationError if they're not
    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    # Calculates the minimum number of observations needed to calculate the technical indicator
    #
    # @param options [Hash] The options for the technical indicator
    #
    # @return [Integer] Returns the minimum number of observations needed to calculate the technical
    #    indicator based on the options provided
    def self.min_data_size(period: 14)
      period.to_i + 1
    end

    # Calculates the vortex indicator (VI) for the data over the given period
    # https://en.wikipedia.org/wiki/Vortex_indicator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param period [Integer] The given period to calculate the VI
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {
    #         :date_time => "2019-01-09T00:00:00.000Z",
    #         :value => {
    #           :negative_vi => 0.9777149447928525,
    #           :positive_vi => 0.8609629970246735
    #         }
    #       },
    #       {
    #         :date_time => "2019-01-08T00:00:00.000Z",
    #         :value => {
    #           :negative_vi => 1.0113586362578701,
    #           :positive_vi => 0.8600571901821686
    #         }
    #       },
    #     ]
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(period: period))

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
