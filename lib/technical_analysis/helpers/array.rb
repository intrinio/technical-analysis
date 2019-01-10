class Array
  def sum
    self.inject(0, :+)
  end

  def sort_by_hash_date_asc
    self.sort_by {|row| row[:date]}
  end

  def sort_by_hash_date_desc
    sort_by_hash_date_asc.reverse
  end
end