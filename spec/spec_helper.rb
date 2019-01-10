require 'csv'

class SpecHelper
  TEST_DATA_PATH = File.join(File.dirname(__FILE__),'ta_test_data.csv')
  FLOAT_KEYS = [:open, :high, :low, :close]
  INTEGER_KEYS = [:volume]

  def self.get_test_data(*columns)
    @data = CSV.read(TEST_DATA_PATH, headers: true)
    columns = columns.map(&:to_sym)
    output = []
    @data.each do |v|
      col_hash = {date: v["date"]}
      columns.each do |col|
        value = v[col.to_s]
        value = value.to_f if FLOAT_KEYS.include?(col)
        value = value.to_i if INTEGER_KEYS.include?(col)
        col_hash[col] = value
      end
      output << col_hash
    end
    output
  end
end


