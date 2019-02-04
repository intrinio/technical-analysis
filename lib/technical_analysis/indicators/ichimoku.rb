module TechnicalAnalysis
  class Ichimoku < Indicator

    def self.indicator_symbol
      "ichimoku"
    end

    def self.indicator_name
      "Ichimoku Kinko Hyo"
    end

    def self.valid_options
      %i(low_period medium_period high_period)
    end

    def self.validate_options(options)
      Validation.validate_options(options, valid_options)
    end

    def self.min_data_size(medium_period: 26, high_period: 52, **params)
      high_period.to_i + medium_period.to_i - 2
    end

    # Calculates the 5 points of Ichimoku Kinko Hyo (Ichimoku) for the data over the given period
    #   1. tenkan_sen    (Conversion Line)
    #   2. kijun_sen     (Base Line)
    #   3. senkou_span_a (Leading Span A)
    #   4. senkou_span_b (Leading Span B)
    #   5. chickou_span  (Lagging Span)
    # https://en.wikipedia.org/wiki/Ichimoku_Kink%C5%8D_Hy%C5%8D
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close)
    # @param low_period [Integer] The given period to calculate tenkan_sen (Conversion Line)
    # @param medium_period [Integer] The given period to calculate kijun_sen (Base Line), senkou_span_a (Leading Span A), and chikou_span (Lagging Span)
    # @param high_period [Integer] The given period to calculate senkou_span_b (Leadning Span B)
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, low_period: 9, medium_period: 26, high_period: 52)
      low_period = low_period.to_i
      medium_period = medium_period.to_i
      high_period = high_period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, high_period + medium_period - 2)

      data = data.sort_by_hash_date_time_asc

      index = high_period + medium_period - 2
      output = []

      while index < data.size
        date_time = data[index][:date_time]

        tenkan_sen = calculate_midpoint(index, low_period, data)
        kinjun_sen = calculate_midpoint(index, medium_period, data)
        senkou_span_a = calculate_senkou_span_a(index, low_period, medium_period, data)
        senkou_span_b = calculate_senkou_span_b(index, medium_period, high_period, data)
        chikou_span = calculate_chikou_span(index, medium_period, data)

        output << {
          date_time: date_time,
          value: {
            tenkan_sen: tenkan_sen,
            kijun_sen: kinjun_sen,
            senkou_span_a: senkou_span_a,
            senkou_span_b: senkou_span_b,
            chikou_span: chikou_span
          }
        }

        index += 1
      end

      output.sort_by_hash_date_time_desc
    end

    def self.lowest_low(prices)
      prices.map { |price| price[:low] }.min
    end

    def self.highest_high(prices)
      prices.map { |price| price[:high] }.max
    end
    
    def self.calculate_midpoint(index, period, data)
      period_range = ((index - (period - 1))..index)
      period_data = data[period_range]
      lowest_low = lowest_low(period_data)
      highest_high = highest_high(period_data)

      ((highest_high + lowest_low) / 2.0)
    end

    def self.calculate_senkou_span_a(index, low_period, medium_period, data)
      mp_ago_index = (index - (medium_period - 1))

      tenkan_sen_mp_ago = calculate_midpoint(mp_ago_index, low_period, data)
      kinjun_sen_mp_ago = calculate_midpoint(mp_ago_index, medium_period, data)

      ((tenkan_sen_mp_ago + kinjun_sen_mp_ago) / 2.0)
    end

    def self.calculate_senkou_span_b(index, medium_period, high_period, data)
      mp_ago_index = (index - (medium_period - 1))

      calculate_midpoint(mp_ago_index, high_period, data)
    end

    def self.calculate_chikou_span(index, medium_period, data)
      mp_ago_index = (index - (medium_period - 1))

      data[mp_ago_index][:close]
    end

  end
end
