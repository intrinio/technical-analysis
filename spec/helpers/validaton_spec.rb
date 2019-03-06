require 'technical-analysis'
require 'spec_helper'

describe 'Validation' do
  describe "date_time validation" do
    input_data = SpecHelper.get_test_data(:close)

    it 'Throws exception for invalid timestamp key' do
      bad_date_time_key_data = input_data.each { |row| row[:bad_timestamp_key] = row.delete :date_time }
      expect { TechnicalAnalysis::Validation.validate_date_time_key(bad_date_time_key_data) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
    end

    it 'Throws exception for invalid timestamp format' do
      bad_date_time_format_data = input_data.each { |row| row[:date_time] = Date.today }
      expect { TechnicalAnalysis::Validation.validate_date_time_key(bad_date_time_format_data) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
    end
  end
end
