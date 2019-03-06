module TechnicalAnalysis
  # Ichimoku Kinko Hyo
  class Ichimoku < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "ichimoku"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Ichimoku Kinko Hyo"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(low_period medium_period high_period)
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
    def self.min_data_size(medium_period: 26, high_period: 52, **params)
      high_period.to_i + medium_period.to_i - 1
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
    # @param high_period [Integer] The given period to calculate senkou_span_b (Leading Span B)
    #
    # @return [Array<IchimokuValue>] An array of IchimokuValue instances
    def self.calculate(data, low_period: 9, medium_period: 26, high_period: 52)
      low_period = low_period.to_i
      medium_period = medium_period.to_i
      high_period = high_period.to_i
      Validation.validate_numeric_data(data, :high, :low, :close)
      Validation.validate_length(data, min_data_size(high_period: high_period, medium_period: medium_period))
      Validation.validate_date_time_key(data)

      data = data.sort_by { |row| row[:date_time] }

      index = high_period + medium_period - 2
      output = []

      while index < data.size
        date_time = data[index][:date_time]

        tenkan_sen = calculate_midpoint(index, low_period, data)
        kinjun_sen = calculate_midpoint(index, medium_period, data)
        senkou_span_a = calculate_senkou_span_a(index, low_period, medium_period, data)
        senkou_span_b = calculate_senkou_span_b(index, medium_period, high_period, data)
        chikou_span = calculate_chikou_span(index, medium_period, data)

        output << IchimokuValue.new(
          date_time: date_time,
          tenkan_sen: tenkan_sen,
          kijun_sen: kinjun_sen,
          senkou_span_a: senkou_span_a,
          senkou_span_b: senkou_span_b,
          chikou_span: chikou_span
        )

        index += 1
      end

      output.sort_by(&:date_time).reverse
    end

    private_class_method def self.lowest_low(prices)
      prices.map { |price| price[:low] }.min
    end

    private_class_method def self.highest_high(prices)
      prices.map { |price| price[:high] }.max
    end
    
    private_class_method def self.calculate_midpoint(index, period, data)
      period_range = ((index - (period - 1))..index)
      period_data = data[period_range]
      lowest_low = lowest_low(period_data)
      highest_high = highest_high(period_data)

      ((highest_high + lowest_low) / 2.0)
    end

    private_class_method def self.calculate_senkou_span_a(index, low_period, medium_period, data)
      mp_ago_index = (index - (medium_period - 1))

      tenkan_sen_mp_ago = calculate_midpoint(mp_ago_index, low_period, data)
      kinjun_sen_mp_ago = calculate_midpoint(mp_ago_index, medium_period, data)

      ((tenkan_sen_mp_ago + kinjun_sen_mp_ago) / 2.0)
    end

    private_class_method def self.calculate_senkou_span_b(index, medium_period, high_period, data)
      mp_ago_index = (index - (medium_period - 1))

      calculate_midpoint(mp_ago_index, high_period, data)
    end

    private_class_method def self.calculate_chikou_span(index, medium_period, data)
      mp_ago_index = (index - (medium_period - 1))

      data[mp_ago_index][:close]
    end

  end

  # The value class to be returned by calculations
  class IchimokuValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the tenkan_sen calculation value
    attr_accessor :tenkan_sen

    # @return [Float] the kijun_sen calculation value
    attr_accessor :kijun_sen

    # @return [Float] the senkou_span_a calculation value
    attr_accessor :senkou_span_a

    # @return [Float] the senkou_span_b calculation value
    attr_accessor :senkou_span_b

    # @return [Float] the chikou_span calculation value
    attr_accessor :chikou_span

    def initialize(date_time: nil, tenkan_sen: nil, kijun_sen: nil, senkou_span_a: nil, senkou_span_b: nil, chikou_span: nil)
      @date_time = date_time
      @tenkan_sen = tenkan_sen
      @kijun_sen = kijun_sen
      @senkou_span_a = senkou_span_a
      @senkou_span_b = senkou_span_b
      @chikou_span = chikou_span
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      {
        date_time: @date_time,
        tenkan_sen: @tenkan_sen,
        kijun_sen: @kijun_sen,
        senkou_span_a: @senkou_span_a,
        senkou_span_b: @senkou_span_b,
        chikou_span: @chikou_span
      }
    end

  end
end
