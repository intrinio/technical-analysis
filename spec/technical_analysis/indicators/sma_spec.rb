require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "SMA" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Sma

    describe 'Simple Moving Average' do
      it 'Calculates SMA (5 day)' do
        output = indicator.calculate(input_data, period: 5, price_key: :close)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :sma=>148.488},
          {:date_time=>"2019-01-08T00:00:00.000Z", :sma=>149.41},
          {:date_time=>"2019-01-07T00:00:00.000Z", :sma=>150.808},
          {:date_time=>"2019-01-04T00:00:00.000Z", :sma=>152.468},
          {:date_time=>"2019-01-03T00:00:00.000Z", :sma=>154.046},
          {:date_time=>"2019-01-02T00:00:00.000Z", :sma=>157.04199999999997},
          {:date_time=>"2018-12-31T00:00:00.000Z", :sma=>154.824},
          {:date_time=>"2018-12-28T00:00:00.000Z", :sma=>153.422},
          {:date_time=>"2018-12-27T00:00:00.000Z", :sma=>153.54199999999997},
          {:date_time=>"2018-12-26T00:00:00.000Z", :sma=>154.49},
          {:date_time=>"2018-12-24T00:00:00.000Z", :sma=>156.27},
          {:date_time=>"2018-12-21T00:00:00.000Z", :sma=>159.692},
          {:date_time=>"2018-12-20T00:00:00.000Z", :sma=>162.642},
          {:date_time=>"2018-12-19T00:00:00.000Z", :sma=>165.46599999999998},
          {:date_time=>"2018-12-18T00:00:00.000Z", :sma=>167.108},
          {:date_time=>"2018-12-17T00:00:00.000Z", :sma=>167.61999999999998},
          {:date_time=>"2018-12-14T00:00:00.000Z", :sma=>168.752},
          {:date_time=>"2018-12-13T00:00:00.000Z", :sma=>169.35399999999998},
          {:date_time=>"2018-12-12T00:00:00.000Z", :sma=>170.108},
          {:date_time=>"2018-12-11T00:00:00.000Z", :sma=>171.626},
          {:date_time=>"2018-12-10T00:00:00.000Z", :sma=>174.864},
          {:date_time=>"2018-12-07T00:00:00.000Z", :sma=>176.66},
          {:date_time=>"2018-12-06T00:00:00.000Z", :sma=>178.872},
          {:date_time=>"2018-12-04T00:00:00.000Z", :sma=>180.11600000000004},
          {:date_time=>"2018-12-03T00:00:00.000Z", :sma=>179.62600000000003},
          {:date_time=>"2018-11-30T00:00:00.000Z", :sma=>177.58599999999998},
          {:date_time=>"2018-11-29T00:00:00.000Z", :sma=>176.32799999999997},
          {:date_time=>"2018-11-28T00:00:00.000Z", :sma=>175.77400000000003},
          {:date_time=>"2018-11-27T00:00:00.000Z", :sma=>174.982},
          {:date_time=>"2018-11-26T00:00:00.000Z", :sma=>177.30599999999998},
          {:date_time=>"2018-11-23T00:00:00.000Z", :sma=>181.088},
          {:date_time=>"2018-11-21T00:00:00.000Z", :sma=>184.91199999999998},
          {:date_time=>"2018-11-20T00:00:00.000Z", :sma=>186.916},
          {:date_time=>"2018-11-19T00:00:00.000Z", :sma=>189.96599999999998},
          {:date_time=>"2018-11-16T00:00:00.000Z", :sma=>191.628},
          {:date_time=>"2018-11-15T00:00:00.000Z", :sma=>193.816},
          {:date_time=>"2018-11-14T00:00:00.000Z", :sma=>197.23200000000003},
          {:date_time=>"2018-11-13T00:00:00.000Z", :sma=>201.862},
          {:date_time=>"2018-11-12T00:00:00.000Z", :sma=>204.17000000000002},
          {:date_time=>"2018-11-09T00:00:00.000Z", :sma=>205.654},
          {:date_time=>"2018-11-08T00:00:00.000Z", :sma=>206.256},
          {:date_time=>"2018-11-07T00:00:00.000Z", :sma=>209.002},
          {:date_time=>"2018-11-06T00:00:00.000Z", :sma=>210.78400000000002},
          {:date_time=>"2018-11-05T00:00:00.000Z", :sma=>212.69},
          {:date_time=>"2018-11-02T00:00:00.000Z", :sma=>214.82000000000002},
          {:date_time=>"2018-11-01T00:00:00.000Z", :sma=>216.584},
          {:date_time=>"2018-10-31T00:00:00.000Z", :sma=>216.1},
          {:date_time=>"2018-10-30T00:00:00.000Z", :sma=>215.346},
          {:date_time=>"2018-10-29T00:00:00.000Z", :sma=>217.23200000000003},
          {:date_time=>"2018-10-26T00:00:00.000Z", :sma=>218.914},
          {:date_time=>"2018-10-25T00:00:00.000Z", :sma=>219.51600000000002},
          {:date_time=>"2018-10-24T00:00:00.000Z", :sma=>218.76},
          {:date_time=>"2018-10-23T00:00:00.000Z", :sma=>219.97999999999996},
          {:date_time=>"2018-10-22T00:00:00.000Z", :sma=>219.86400000000003},
          {:date_time=>"2018-10-19T00:00:00.000Z", :sma=>219.206},
          {:date_time=>"2018-10-18T00:00:00.000Z", :sma=>219.766},
          {:date_time=>"2018-10-17T00:00:00.000Z", :sma=>219.452},
          {:date_time=>"2018-10-16T00:00:00.000Z", :sma=>218.48600000000002},
          {:date_time=>"2018-10-15T00:00:00.000Z", :sma=>219.43}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('sma')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Simple Moving Average')
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
        expect { indicator.validate_options(invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(4)
      end
    end
  end
end
