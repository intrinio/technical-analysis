module TechnicalAnalysis
  class ArrayHelper

    def self.sum(data)
      data.inject(0, :+)
    end

    def self.mean(data)
      sum(data) / data.size.to_f
    end

    def self.average(data)
      sum(data) / data.size.to_f
    end

    def self.sample_variance(data)
      m = mean(data)
      sum = data.inject(0) { |accum, i| accum + (i - m)**2 }
      sum / (data.size - 1).to_f
    end

    def self.standard_deviation(data)
      Math.sqrt(sample_variance(data))
    end

  end
end
