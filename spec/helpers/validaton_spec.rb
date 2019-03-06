require 'technical-analysis'
require 'spec_helper'

describe 'Validation' do
  describe "date_time validation" do
    input_data = SpecHelper.get_test_data(:close)

    it 'Throws exception for invalid timestamp key' do
      bad_date_time_key_data = input_data.each { |row| row[:bad_timestamp_key] = row.delete :date_time }
      expect { TechnicalAnalysis::Validation.validate_date_time_key(bad_date_time_key_data) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
    end
  end

  describe "numeric validation" do
    input_data = SpecHelper.get_test_data(:close)

    it 'Throws exception for non numeric price data' do
      non_numeric_data = input_data.each { |row| row[:close] = row.delete(:close).to_s }
      expect { TechnicalAnalysis::Validation.validate_numeric_data(non_numeric_data, :close) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
    end
  end
end
