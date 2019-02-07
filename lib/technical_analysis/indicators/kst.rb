module TechnicalAnalysis
  class Kst < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "kst"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Know Sure Thing"
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      %i(period roc1 roc2 roc3 roc4 sma1 sma2 sma3 sma4 price_key)
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
    def self.min_data_size(roc4: 30, sma4: 15, **params)
      roc4.to_i + sma4.to_i - 1
    end

    # Calculates the know sure thing (KST) for the data over the given period
    # https://en.wikipedia.org/wiki/KST_oscillator
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param roc1 [Integer] The given period to calculate the rate-of-change for RCMA1
    # @param roc2 [Integer] The given period to calculate the rate-of-change for RCMA2
    # @param roc3 [Integer] The given period to calculate the rate-of-change for RCMA3
    # @param roc4 [Integer] The given period to calculate the rate-of-change for RCMA4
    # @param sma1 [Integer] The given period to calculate the SMA of the rate-of-change for  RCMA1
    # @param sma2 [Integer] The given period to calculate the SMA of the rate-of-change for RCMA2
    # @param sma3 [Integer] The given period to calculate the SMA of the rate-of-change for RCMA3
    # @param sma4 [Integer] The given period to calculate the SMA of the rate-of-change for RCMA4
    # @param price_key [Symbol] The hash key for the price data. Default :value
    #
    # @return [Array<Hash>]
    #
    #   An array of hashes with keys (:date_time, :value). Example output:
    #
    #     [
    #       {:date_time => "2019-01-09T00:00:00.000Z", :value => -140.9140022298261},
    #       {:date_time => "2019-01-08T00:00:00.000Z", :value => -148.9261153101682},
    #     ]
    def self.calculate(data, roc1: 10, roc2: 15, roc3: 20, roc4: 30, sma1: 10, sma2: 10, sma3: 10, sma4: 15, price_key: :value)
      roc1 = roc1.to_i
      roc2 = roc2.to_i
      roc3 = roc3.to_i
      roc4 = roc4.to_i
      sma1 = sma1.to_i
      sma2 = sma2.to_i
      sma3 = sma3.to_i
      sma4 = sma4.to_i
      price_key = price_key.to_sym
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, roc4 + sma4 - 1)

      data = data.sort_by_hash_date_time_asc

      index = roc4 + sma4 - 2
      output = []

      while index < data.size
        date_time = data[index][:date_time] 
        rcma1 = calculate_rcma(data, index, price_key, roc1, sma1)
        rcma2 = calculate_rcma(data, index, price_key, roc2, sma2)
        rcma3 = calculate_rcma(data, index, price_key, roc3, sma3)
        rcma4 = calculate_rcma(data, index, price_key, roc4, sma4)

        kst = (1 * rcma1) + (2 * rcma2) + (3 * rcma3) + (4 * rcma4)

        output << { date_time: date_time, value: kst }
        index += 1
      end

      output.sort_by_hash_date_time_desc
    end

    private_class_method def self.calculate_rcma(data, index, price_key, roc, sma)
      roc_data = []
      index_range = (index - sma + 1)..index

      index_range.each do |i|
        last_price = data[i][price_key]
        starting_price = data[i - roc + 1][price_key]

        roc_data << (last_price - starting_price) / starting_price * 100
      end

      roc_data.sum / sma.to_f
    end

  end
end
