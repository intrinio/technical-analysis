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

    def self.roster
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
    def self.find(indicator_symbol)
      self.roster.each do |indicator|
        return indicator if indicator.indicator_symbol == indicator_symbol
      end

      nil
    end

    # Find the applicable indicator and looks up the value
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

    # Calculates the minimum data size for an indicator
    def self.min_data_size(indicator_symbol, options)
      raise "#{self.name} did not implement min_data_size"
      nil
    end

    # Validates the options for the indicator
    def self.validate_options(options)
      raise "#{self.name} did not implement validate_options"
      false
    end

    # Returns the valid options for the indicator
    def self.valid_options
      raise "#{self.name} did not implement valid_options"
      []
    end

    # Returns the symbol string of the indicator
    def self.indicator_symbol
      raise "#{self.name} did not implement indicator_symbol"
    end

    # Returns the name string of the indicator
    def self.indicator_name
      raise "#{self.name} did not implement indicator_name"
    end

  end
end
