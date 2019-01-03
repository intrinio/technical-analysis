class Validation

  def self.validate_price_data(data)
    unless data.values.all? { |v| v.class == Float || v.class == Integer}
      raise ValidationError.new "Invalid Data. Price is not a number"
    end
  end

  def self.validate_length(data, size)
    raise ValidationError.new "Not enough data for that period" if data.size < size
  end

  class ValidationError < StandardError; end
end