class Validation

  def self.validate_numeric_data(data, *keys)
    keys.each do |key|
      unless data.all? { |v| v[key].is_a? Numeric }
        raise ValidationError.new "Invalid Data. '#{key}' is not valid price data."
      end
    end
  end

  def self.validate_length(data, size)
    raise ValidationError.new "Not enough data for that period" if data.size < size
  end

  class ValidationError < StandardError; end

end
