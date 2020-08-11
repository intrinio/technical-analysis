require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "WMA" do
    input_data = SpecHelper.get_test_data(:close, date_time_key: :timestep)
    indicator = TechnicalAnalysis::Wma

    describe 'Weighted Moving Average' do
      it 'Calculates WMA (5 day)' do
        output = indicator.calculate(input_data, period: 5, price_key: :close, date_time_key: :timestep)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :wma=>150.13666666666666},
          {:date_time=>"2019-01-08T00:00:00.000Z", :wma=>148.83666666666667},
          {:date_time=>"2019-01-07T00:00:00.000Z", :wma=>148.856},
          {:date_time=>"2019-01-04T00:00:00.000Z", :wma=>150.36866666666666},
          {:date_time=>"2019-01-03T00:00:00.000Z", :wma=>152.29733333333334},
          {:date_time=>"2019-01-02T00:00:00.000Z", :wma=>157.248},
          {:date_time=>"2018-12-31T00:00:00.000Z", :wma=>156.216},
          {:date_time=>"2018-12-28T00:00:00.000Z", :wma=>154.77666666666667},
          {:date_time=>"2018-12-27T00:00:00.000Z", :wma=>153.88066666666666},
          {:date_time=>"2018-12-26T00:00:00.000Z", :wma=>153.32733333333334},
          {:date_time=>"2018-12-24T00:00:00.000Z", :wma=>153.02733333333333},
          {:date_time=>"2018-12-21T00:00:00.000Z", :wma=>157.31466666666665},
          {:date_time=>"2018-12-20T00:00:00.000Z", :wma=>161.28533333333334},
          {:date_time=>"2018-12-19T00:00:00.000Z", :wma=>164.164},
          {:date_time=>"2018-12-18T00:00:00.000Z", :wma=>166.23666666666665},
          {:date_time=>"2018-12-17T00:00:00.000Z", :wma=>166.75333333333333},
          {:date_time=>"2018-12-14T00:00:00.000Z", :wma=>168.35733333333332},
          {:date_time=>"2018-12-13T00:00:00.000Z", :wma=>169.64866666666666},
          {:date_time=>"2018-12-12T00:00:00.000Z", :wma=>169.368},
          {:date_time=>"2018-12-11T00:00:00.000Z", :wma=>170.21},
          {:date_time=>"2018-12-10T00:00:00.000Z", :wma=>172.28799999999998},
          {:date_time=>"2018-12-07T00:00:00.000Z", :wma=>174.64133333333334},
          {:date_time=>"2018-12-06T00:00:00.000Z", :wma=>178.102},
          {:date_time=>"2018-12-04T00:00:00.000Z", :wma=>179.90066666666667},
          {:date_time=>"2018-12-03T00:00:00.000Z", :wma=>180.87933333333334},
          {:date_time=>"2018-11-30T00:00:00.000Z", :wma=>178.46800000000002},
          {:date_time=>"2018-11-29T00:00:00.000Z", :wma=>177.71733333333333},
          {:date_time=>"2018-11-28T00:00:00.000Z", :wma=>176.4586666666667},
          {:date_time=>"2018-11-27T00:00:00.000Z", :wma=>174.47266666666667},
          {:date_time=>"2018-11-26T00:00:00.000Z", :wma=>175.49466666666666},
          {:date_time=>"2018-11-23T00:00:00.000Z", :wma=>177.65066666666667},
          {:date_time=>"2018-11-21T00:00:00.000Z", :wma=>181.858},
          {:date_time=>"2018-11-20T00:00:00.000Z", :wma=>185.23666666666668},
          {:date_time=>"2018-11-19T00:00:00.000Z", :wma=>189.56533333333334},
          {:date_time=>"2018-11-16T00:00:00.000Z", :wma=>191.488},
          {:date_time=>"2018-11-15T00:00:00.000Z", :wma=>191.58333333333334},
          {:date_time=>"2018-11-14T00:00:00.000Z", :wma=>193.524},
          {:date_time=>"2018-11-13T00:00:00.000Z", :wma=>198.54466666666667},
          {:date_time=>"2018-11-12T00:00:00.000Z", :wma=>202.52466666666666},
          {:date_time=>"2018-11-09T00:00:00.000Z", :wma=>206.35266666666666},
          {:date_time=>"2018-11-08T00:00:00.000Z", :wma=>206.948},
          {:date_time=>"2018-11-07T00:00:00.000Z", :wma=>207.11866666666666},
          {:date_time=>"2018-11-06T00:00:00.000Z", :wma=>207.39666666666665},
          {:date_time=>"2018-11-05T00:00:00.000Z", :wma=>210.37},
          {:date_time=>"2018-11-02T00:00:00.000Z", :wma=>214.78},
          {:date_time=>"2018-11-01T00:00:00.000Z", :wma=>217.81466666666665},
          {:date_time=>"2018-10-31T00:00:00.000Z", :wma=>215.7746666666667},
          {:date_time=>"2018-10-30T00:00:00.000Z", :wma=>214.60333333333335},
          {:date_time=>"2018-10-29T00:00:00.000Z", :wma=>215.91400000000002},
          {:date_time=>"2018-10-26T00:00:00.000Z", :wma=>218.13866666666667},
          {:date_time=>"2018-10-25T00:00:00.000Z", :wma=>219.21066666666667},
          {:date_time=>"2018-10-24T00:00:00.000Z", :wma=>218.864},
          {:date_time=>"2018-10-23T00:00:00.000Z", :wma=>220.494},
          {:date_time=>"2018-10-22T00:00:00.000Z", :wma=>219.53866666666667},
          {:date_time=>"2018-10-19T00:00:00.000Z", :wma=>219.05733333333333},
          {:date_time=>"2018-10-18T00:00:00.000Z", :wma=>219.20933333333335},
          {:date_time=>"2018-10-17T00:00:00.000Z", :wma=>220.35333333333335},
          {:date_time=>"2018-10-16T00:00:00.000Z", :wma=>219.452},
          {:date_time=>"2018-10-15T00:00:00.000Z", :wma=>218.54533333333336}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('wma')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Weighted Moving Average')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period price_key date_time_key))
      end

      it 'Validates options' do
        valid_options = { period: 22, price_key: :close, date_time_key: :timestep }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(**options)).to eq(4)
      end
    end
  end
end
