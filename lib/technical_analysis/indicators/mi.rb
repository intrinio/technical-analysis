module TechnicalAnalysis
  # Mass Index
  class Mi < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "mi"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Mass Index"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(ema_period sum_period)
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
    def self.min_data_size(ema_period: 9, sum_period: 25)
      (ema_period.to_i * 2) + sum_period.to_i - 2
    end

    # Calculates the mass index (MI) for the data over the given period
    # https://en.wikipedia.org/wiki/Mass_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low)
    # @param ema_period [Integer] The given period to calculate the EMA and EMA of EMA
    # @param sum_period [Integer] The given period to calculate the sum of EMA ratios
    #
    # @return [Array<MiValue>] An array of MiValue instances
    def self.calculate(data, ema_period: 9, sum_period: 25)
      ema_period = ema_period.to_i
      sum_period = sum_period.to_i
      Validation.validate_numeric_data(data, :high, :low)
      Validation.validate_length(data, min_data_size(ema_period: ema_period, sum_period: sum_period))

      data = data.sort_by_date_time_asc

      double_emas = []
      high_low_diffs = []
      output = []
      ratio_of_emas = []
      single_emas = []

      data.each do |v|
        high_low_diff = v[:high] - v[:low]
        high_low_diffs << high_low_diff

        if high_low_diffs.size == ema_period
          single_ema = StockCalculation.ema(high_low_diff, high_low_diffs, ema_period, single_emas.last)
          single_emas << single_ema

          if single_emas.size == ema_period
            double_ema = StockCalculation.ema(single_emas.last, single_emas, ema_period, double_emas.last)
            double_emas << double_ema

            ratio_of_emas << (single_ema / double_ema)

            if ratio_of_emas.size == sum_period
              output << MiValue.new(date_time: v[:date_time], mi: ratio_of_emas.sum)

              double_emas.shift
              ratio_of_emas.shift
            end

            single_emas.shift
          end

          high_low_diffs.shift
        end
      end

      output.sort_by_date_time_desc
    end

  end

  # The value class to be returned by calculations
  class MiValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the mi calculation value
    attr_accessor :mi

    def initialize(date_time: nil, mi: nil)
      @date_time = date_time
      @mi = mi
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, mi: @mi }
    end

  end
end
