module TechnicalAnalysis
  class Indicator

    CALCULATIONS = [
      :indicator_name,
      :indicator_symbol,
      :min_data_size,
      :technicals,
      :valid_options,
      :validate_options,
    ].freeze

    private_constant :CALCULATIONS

    # Returns an array of TechnicalAnalysis modules
    #
    # @return [Array] A list of TechnicalAnalysis::Class
    private_class_method def self.roster
      [
        TechnicalAnalysis::Adi,
        TechnicalAnalysis::Adtv,
        TechnicalAnalysis::Adx,
        TechnicalAnalysis::Ao,
        TechnicalAnalysis::Atr,
        TechnicalAnalysis::Bb,
        TechnicalAnalysis::Cci,
        TechnicalAnalysis::Cmf,
        TechnicalAnalysis::Cr,
        TechnicalAnalysis::Dc,
        TechnicalAnalysis::Dlr,
        TechnicalAnalysis::Dpo,
        TechnicalAnalysis::Dr,
        TechnicalAnalysis::Eom,
        TechnicalAnalysis::Evm,
        TechnicalAnalysis::Fi,
        TechnicalAnalysis::Ichimoku,
        TechnicalAnalysis::Kc,
        TechnicalAnalysis::Kst,
        TechnicalAnalysis::Macd,
        TechnicalAnalysis::Mfi,
        TechnicalAnalysis::Mi,
        TechnicalAnalysis::Nvi,
        TechnicalAnalysis::Obv,
        TechnicalAnalysis::ObvMean,
        TechnicalAnalysis::Rsi,
        TechnicalAnalysis::Sma,
        TechnicalAnalysis::Sr,
        TechnicalAnalysis::Trix,
        TechnicalAnalysis::Tsi,
        TechnicalAnalysis::Uo,
        TechnicalAnalysis::Vi,
        TechnicalAnalysis::Vpt,
        TechnicalAnalysis::Wr,
      ]
    end

    # Finds the applicable indicator and returns an instance
    #
    # @param indicator_symbol [String] Downcased string of the indicator symbol
    #
    # @return TechnicalAnalysis::ClassName
    def self.find(indicator_symbol)
      roster.each do |indicator|
        return indicator if indicator.indicator_symbol == indicator_symbol
      end

      nil
    end

    # Find the applicable indicator and looks up the value
    #
    # @param indicator_symbol [String] Downcased string of the indicator symbol
    # @param data [Array] Array of hashes of price data to perform calcualtion on
    # @param calculation [Symbol] The calculation to be performed on the requested indicator and params
    # @param options [Hash] A hash containing options for the requested calculation
    #
    # @return Returns the requested calculation
    def self.calculate(indicator_symbol, data, calculation, options={})
      return nil unless CALCULATIONS.include? calculation

      indicator = find(indicator_symbol)
      raise "Indicator not found!" if indicator.nil?

      case calculation
      when :indicator_name; indicator.indicator_name
      when :indicator_symbol; indicator.indicator_symbol
      when :technicals; indicator.calculate(data, options)
      when :min_data_size; indicator.min_data_size(options)
      when :valid_options; indicator.valid_options
      when :validate_options; indicator.validate_options(options)
      else nil
      end
    end

    # Calculates the minimum number of observations needed to calculate the technical indicator
    #
    # @param options [Hash] The options for the technical indicator
    #
    # @return [Integer] Returns the minimum number of observations needed to calculate the technical
    #    indicator based on the options provided
    def self.min_data_size(indicator_symbol, options)
      raise "#{self.name} did not implement min_data_size"
      nil
    end

    # Validates the provided options for this technical indicator
    #
    # @param options [Hash] The options for the technical indicator to be validated
    #
    # @return [Boolean] Returns true if options are valid or raises a ValidationError if they're not
    def self.validate_options(options)
      raise "#{self.name} did not implement validate_options"
      false
    end

    # Returns an array of valid keys for options for this technical indicator
    #
    # @return [Array] An array of keys as symbols for valid options for this technical indicator
    def self.valid_options
      raise "#{self.name} did not implement valid_options"
      []
    end

    # Returns the symbol of the technical indicator
    #
    # @return [String] A string of the symbol of the technical indicator
    def self.indicator_symbol
      raise "#{self.name} did not implement indicator_symbol"
    end

    # Returns the name of the technical indicator
    #
    # @return [String] A string of the name of the technical indicator
    def self.indicator_name
      raise "#{self.name} did not implement indicator_name"
    end

  end
end
