module TechnicalAnalysis
  class Adx < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "adx"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Average Directional Index"
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
    # @return [Boolean] Returns true if options vare valid or raises an error if they're not
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
      period.to_i * 2
    end

    # Calculates the average directional index (ADX) for the data over the given period
    # https://en.wikipedia.org/wiki/Average_directional_movement_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param period [Integer] The given period to calculate the ADX
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {
    #         :date_time => "2019-01-09T00:00:00.000Z",
    #         :value => {
    #           :adx => 46.70506819299097,
    #           :di_neg => 33.86727845364526,
    #           :di_pos=>18.75156069669946
    #         }
    #       },
    #       {
    #         :date_time => "2019-01-08T00:00:00.000Z",
    #         :value => {
    #           :adx => 48.08801057392937,
    #           :di_neg => 35.92768510004254,
    #           :di_pos=>16.527665969119678
    #         }
    #       },
    #     ]
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, period * 2)

      data = data.sort_by_hash_date_time_asc
  
      dx_values = []
      output = []
      periodic_values = []
      prev_adx = nil
      prev_price = data.shift
      smoothed_values = []

      data.each do |v|
        tr = StockCalculation.true_range(v[:high], v[:low], prev_price[:close])

        dm_pos, dm_neg = calculate_dm(v, prev_price)

        periodic_values << { tr: tr, dm_pos: dm_pos, dm_neg: dm_neg }

        if periodic_values.size == period
          tr_period, dm_pos_period, dm_neg_period = smooth_periodic_values(period, periodic_values, smoothed_values)
          smoothed_values << { tr: tr_period, dm_pos: dm_pos_period, dm_neg: dm_neg_period }

          di_pos = (dm_pos_period / tr_period) * 100.00
          di_neg = (dm_neg_period / tr_period) * 100.00
          dx = ((dm_pos_period - dm_neg_period).abs / (dm_pos_period + dm_neg_period) * 100.00)

          dx_values << dx

          if dx_values.size == period
            if prev_adx.nil?
              adx = dx_values.average
            else
              adx = ((prev_adx * 13) + dx) / period.to_f
            end

            output << {
              date_time: v[:date_time],
              value: {
                adx: adx,
                di_pos: di_pos,
                di_neg: di_neg
              }
            }

            prev_adx = adx
            dx_values.shift
          end

          periodic_values.shift
        end

        prev_price = v
      end

      output.sort_by_hash_date_time_desc
    end

    private_class_method def self.calculate_dm(current_price, prev_price)
      if current_price[:high] - prev_price[:high] > prev_price[:low] - current_price[:low]
        dm_pos = [(current_price[:high] - prev_price[:high]), 0].max
        dm_neg = 0
      elsif prev_price[:low] - current_price[:low] > current_price[:high] - prev_price[:high]
        dm_pos = 0
        dm_neg = [(prev_price[:low] - current_price[:low]), 0].max
      else
        dm_pos = 0
        dm_neg = 0
      end

      [dm_pos, dm_neg]
    end
  
    private_class_method def self.smooth_periodic_values(period, periodic_values, smoothed_values)
      if smoothed_values.empty?
        tr_period = periodic_values.map { |pv| pv[:tr] }.sum
        dm_pos_period = periodic_values.map { |pv| pv[:dm_pos] }.sum
        dm_neg_period = periodic_values.map { |pv| pv[:dm_neg] }.sum
      else
        prev_value = smoothed_values.last
        current_value = periodic_values.last

        tr_period = prev_value[:tr] - (prev_value[:tr] / period) + current_value[:tr]
        dm_pos_period = prev_value[:dm_pos] - (prev_value[:dm_pos] / period) + current_value[:dm_pos]
        dm_neg_period = prev_value[:dm_neg] - (prev_value[:dm_neg] / period) + current_value[:dm_neg]
      end

      [tr_period, dm_pos_period, dm_neg_period]
    end

  end
end
