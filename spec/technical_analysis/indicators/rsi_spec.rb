require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "RSI" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Rsi

    describe 'Relative Strength Index' do
      it 'Calculates RSI (14 day)' do
        output = indicator.calculate(input_data, period: 14, price_key: :close)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>41.01572095202713},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>38.100858593859655},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>34.80538400125879},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>35.00790948034705},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>27.835833051062522},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>37.90003559360193},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>37.66054013673465},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>35.7297472286003},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>35.63166885267985},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>36.28727515078207},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>22.94077952430888},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>24.757134961511937},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>27.973957664061984},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>30.416532991054595},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>33.926041361905774},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>30.880956115136144},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>31.866930881658718},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>35.61772436774288},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>33.146531878947414},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>32.53565170863392},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>33.115551932880564},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>31.82436379692355},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>35.38441991619841},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>36.58615110748291},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>42.06016450933706},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>35.1442970032345},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>35.760430191057694},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>36.61457624117541},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>29.027101402280678},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>29.211255846774762},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>26.558433878585916},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>28.467396310763007},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>28.552282046348225},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>32.554453236286506},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>36.677863857193564},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>34.550163030510646},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>29.78632377839773},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>32.36268849740294},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>33.31877385045367},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>38.99885805229995},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>41.56699725744853},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>42.51108193242363},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>36.875893042068746},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>34.78189708111985},
          {:date_time=>"2018-11-02T00:00:00.000Z", :value=>37.93941116682432},
          {:date_time=>"2018-11-01T00:00:00.000Z", :value=>48.08268788472883},
          {:date_time=>"2018-10-31T00:00:00.000Z", :value=>44.96841382331871},
          {:date_time=>"2018-10-30T00:00:00.000Z", :value=>39.38109368376431},
          {:date_time=>"2018-10-29T00:00:00.000Z", :value=>38.27160493827161}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+2, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('rsi')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Relative Strength Index')
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
        expect(indicator.min_data_size(options)).to eq(5)
      end
    end
  end
end
