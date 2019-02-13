require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "DC" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Dc

    describe 'Donchian Channel' do
      it 'Calculates DC (20 day)' do
        output = indicator.calculate(input_data, period: 20, price_key: :close)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :lower_bound=>142.19, :upper_bound=>170.95},
          {:date_time=>"2019-01-08T00:00:00.000Z", :lower_bound=>142.19, :upper_bound=>170.95},
          {:date_time=>"2019-01-07T00:00:00.000Z", :lower_bound=>142.19, :upper_bound=>170.95},
          {:date_time=>"2019-01-04T00:00:00.000Z", :lower_bound=>142.19, :upper_bound=>174.72},
          {:date_time=>"2019-01-03T00:00:00.000Z", :lower_bound=>142.19, :upper_bound=>176.69},
          {:date_time=>"2019-01-02T00:00:00.000Z", :lower_bound=>146.83, :upper_bound=>184.82},
          {:date_time=>"2018-12-31T00:00:00.000Z", :lower_bound=>146.83, :upper_bound=>184.82},
          {:date_time=>"2018-12-28T00:00:00.000Z", :lower_bound=>146.83, :upper_bound=>184.82},
          {:date_time=>"2018-12-27T00:00:00.000Z", :lower_bound=>146.83, :upper_bound=>184.82},
          {:date_time=>"2018-12-26T00:00:00.000Z", :lower_bound=>146.83, :upper_bound=>184.82},
          {:date_time=>"2018-12-24T00:00:00.000Z", :lower_bound=>146.83, :upper_bound=>184.82},
          {:date_time=>"2018-12-21T00:00:00.000Z", :lower_bound=>150.73, :upper_bound=>184.82},
          {:date_time=>"2018-12-20T00:00:00.000Z", :lower_bound=>156.83, :upper_bound=>184.82},
          {:date_time=>"2018-12-19T00:00:00.000Z", :lower_bound=>160.89, :upper_bound=>184.82},
          {:date_time=>"2018-12-18T00:00:00.000Z", :lower_bound=>163.94, :upper_bound=>185.86},
          {:date_time=>"2018-12-17T00:00:00.000Z", :lower_bound=>163.94, :upper_bound=>193.53},
          {:date_time=>"2018-12-14T00:00:00.000Z", :lower_bound=>165.48, :upper_bound=>193.53},
          {:date_time=>"2018-12-13T00:00:00.000Z", :lower_bound=>168.49, :upper_bound=>193.53},
          {:date_time=>"2018-12-12T00:00:00.000Z", :lower_bound=>168.49, :upper_bound=>193.53},
          {:date_time=>"2018-12-11T00:00:00.000Z", :lower_bound=>168.49, :upper_bound=>194.17},
          {:date_time=>"2018-12-10T00:00:00.000Z", :lower_bound=>168.49, :upper_bound=>204.47},
          {:date_time=>"2018-12-07T00:00:00.000Z", :lower_bound=>168.49, :upper_bound=>208.49},
          {:date_time=>"2018-12-06T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>209.95},
          {:date_time=>"2018-12-04T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>209.95},
          {:date_time=>"2018-12-03T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>209.95},
          {:date_time=>"2018-11-30T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>209.95},
          {:date_time=>"2018-11-29T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>222.22},
          {:date_time=>"2018-11-28T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>222.22},
          {:date_time=>"2018-11-27T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>222.22},
          {:date_time=>"2018-11-26T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>222.22},
          {:date_time=>"2018-11-23T00:00:00.000Z", :lower_bound=>172.29, :upper_bound=>222.22},
          {:date_time=>"2018-11-21T00:00:00.000Z", :lower_bound=>176.78, :upper_bound=>222.22},
          {:date_time=>"2018-11-20T00:00:00.000Z", :lower_bound=>176.98, :upper_bound=>222.22},
          {:date_time=>"2018-11-19T00:00:00.000Z", :lower_bound=>185.86, :upper_bound=>222.73},
          {:date_time=>"2018-11-16T00:00:00.000Z", :lower_bound=>186.8, :upper_bound=>222.73},
          {:date_time=>"2018-11-15T00:00:00.000Z", :lower_bound=>186.8, :upper_bound=>222.73},
          {:date_time=>"2018-11-14T00:00:00.000Z", :lower_bound=>186.8, :upper_bound=>222.73},
          {:date_time=>"2018-11-13T00:00:00.000Z", :lower_bound=>192.23, :upper_bound=>222.73},
          {:date_time=>"2018-11-12T00:00:00.000Z", :lower_bound=>194.17, :upper_bound=>222.73},
          {:date_time=>"2018-11-09T00:00:00.000Z", :lower_bound=>201.59, :upper_bound=>222.73},
          {:date_time=>"2018-11-08T00:00:00.000Z", :lower_bound=>201.59, :upper_bound=>222.73},
          {:date_time=>"2018-11-07T00:00:00.000Z", :lower_bound=>201.59, :upper_bound=>222.73},
          {:date_time=>"2018-11-06T00:00:00.000Z", :lower_bound=>201.59, :upper_bound=>222.73},
          {:date_time=>"2018-11-05T00:00:00.000Z", :lower_bound=>201.59, :upper_bound=>226.87}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('dc')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Donchian Channel')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period price_key))
      end

      it 'Validates options' do
        valid_options = { period: 22, price_key: :close }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(4)
      end
    end
  end
end
