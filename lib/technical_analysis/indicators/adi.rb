module TechnicalAnalysis
  class Adi

    # Calculates the Accumulation/Distribution Index for the given data
    # https://en.wikipedia.org/wiki/Accumulation/distribution_index
    # 
    # @param data [Array] Array of hashes with keys (:date, :high, :low, :close, :volume)
    # @return [Hash] A hash of the results with keys (:date, :value)
    def self.calculate(data)
      Validation.validate_numeric_data(data, :high, :low, :close, :volume)

      data = data.sort_by_hash_date_asc

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

        ads << { date: values[:date], value: ad }
      end
      ads
    end

  end
end
