module TechnicalAnalysis
  # Ease of Movement
  class Evm < Indicator

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      "evm"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      "Ease of Movement"
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

    # Calculates the ease of movement (EVM) for the data over the given period
    # https://en.wikipedia.org/wiki/Ease_of_movement
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :volume)
    # @param period [Integer] The given period to calculate the EVM
    #
    # @return [Array<EvmValue>] An array of EvmValue instances
    def self.calculate(data, period: 14)
      period = period.to_i
      Validation.validate_numeric_data(data, :high, :low, :volume)
      Validation.validate_length(data, min_data_size(period: period))
      Validation.validate_date_time_key(data)

      data = data.sort_by { |row| row[:date_time] }

      output = []
      period_values = []
      prev_price = data.shift

      data.each do |v|
        distance_moved = ((v[:high] + v[:low]) / 2) - ((prev_price[:high] + prev_price[:low]) / 2)
        box_ratio = (v[:volume] / 100_000_000.00) / (v[:high] - v[:low])
        emv = distance_moved / box_ratio

        period_values << emv

        if period_values.size == period
          output << EvmValue.new(date_time: v[:date_time], evm: period_values.average)
          period_values.shift
        end

        prev_price = v
      end

      output.sort_by(&:date_time).reverse
    end

  end

  # The value class to be returned by calculations
  class EvmValue

    # @return [String] the date_time of the obversation as it was provided
    attr_accessor :date_time

    # @return [Float] the evm calculation value
    attr_accessor :evm

    def initialize(date_time: nil, evm: nil)
      @date_time = date_time
      @evm = evm
    end

    # @return [Hash] the attributes as a hash
    def to_hash
      { date_time: @date_time, evm: @evm }
    end

  end
end
