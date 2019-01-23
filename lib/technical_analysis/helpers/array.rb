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

  def sort_by_hash_date_asc
    self.sort_by { |row| row[:date] }
  end

  def sort_by_hash_date_desc
    sort_by_hash_date_asc.reverse
  end

  alias_method :average, :mean

end
