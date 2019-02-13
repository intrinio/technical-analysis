class Array

  def sum
    self.inject(0, :+)
  end

  def mean
    self.sum / self.size.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0) { |accum, i| accum + (i - m)**2 }
    sum / (self.size - 1).to_f
  end

  def standard_deviation
    Math.sqrt(self.sample_variance)
  end

  def sort_by_date_time_asc
    if self.first.is_a? Hash
      self.sort_by { |row| row[:date_time] }
    else
      self.sort_by(&:date_time)
    end
  end

  def sort_by_date_time_desc
    sort_by_date_time_asc.reverse
  end

  alias_method :average, :mean

end
