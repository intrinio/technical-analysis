module TechnicalAnalysis
  class Adi < Indicator

    VALID_OPTIONS = [].freeze

    def self.indicator_symbol
      "adi"
    end

    def self.indicator_name
      "Accumulation/Distribution Index"
    end

    def self.valid_options
      []
    end

    def self.validate_options(options)
      return true if options == {}
      raise ValidationError.new "This indicator doesn't accept any options."
    end

    def self.min_data_size(**params)
      1
    end

    # Calculates the Accumulation/Distribution Index (ADI) for the given data
    # https://en.wikipedia.org/wiki/Accumulation/distribution_index
    #
    # @param data [Array] Array of hashes with keys (:date_time, :high, :low, :close, :volume)
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data)
      Validation.validate_numeric_data(data, :high, :low, :close, :volume)

      data = data.sort_by_hash_date_time_asc

      ad = 0
      ads = []
      clv = 0
      prev_ad = 0

      data.each_with_index do |values, i|
        if values[:high] == values[:low]
          clv = 0
        else
          clv = ((values[:close] - values[:low]) - (values[:high] - values[:close])) / (values[:high] - values[:low])
        end

        ad = prev_ad + (clv * values[:volume])
        prev_ad = ad

        ads << { date_time: values[:date_time], value: ad }
      end
      ads.sort_by_hash_date_time_desc
    end

  end
end
