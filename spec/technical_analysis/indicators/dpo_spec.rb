require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "DPO" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Dpo

    describe 'Detrended Price Oscillator' do
      it 'Calculates DPO (20 day)' do
        output = indicator.calculate(input_data, period: 20, price_key: :close)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :dpo=>-15.774999999999977},
          {:date_time=>"2019-01-08T00:00:00.000Z", :dpo=>-19.607999999999976},
          {:date_time=>"2019-01-07T00:00:00.000Z", :dpo=>-23.730500000000006},
          {:date_time=>"2019-01-04T00:00:00.000Z", :dpo=>-24.407999999999987},
          {:date_time=>"2019-01-03T00:00:00.000Z", :dpo=>-31.726499999999987},
          {:date_time=>"2019-01-02T00:00:00.000Z", :dpo=>-17.36949999999996},
          {:date_time=>"2018-12-31T00:00:00.000Z", :dpo=>-18.922999999999973},
          {:date_time=>"2018-12-28T00:00:00.000Z", :dpo=>-21.498999999999995},
          {:date_time=>"2018-12-27T00:00:00.000Z", :dpo=>-22.642999999999972},
          {:date_time=>"2018-12-26T00:00:00.000Z", :dpo=>-22.876499999999993},
          {:date_time=>"2018-12-24T00:00:00.000Z", :dpo=>-35.0085},
          {:date_time=>"2018-12-21T00:00:00.000Z", :dpo=>-33.053},
          {:date_time=>"2018-12-20T00:00:00.000Z", :dpo=>-29.025999999999982},
          {:date_time=>"2018-12-19T00:00:00.000Z", :dpo=>-26.41850000000005},
          {:date_time=>"2018-12-18T00:00:00.000Z", :dpo=>-22.48350000000005},
          {:date_time=>"2018-12-17T00:00:00.000Z", :dpo=>-25.746500000000054},
          {:date_time=>"2018-12-14T00:00:00.000Z", :dpo=>-26.388500000000022},
          {:date_time=>"2018-12-13T00:00:00.000Z", :dpo=>-22.884000000000043},
          {:date_time=>"2018-12-12T00:00:00.000Z", :dpo=>-26.35200000000006},
          {:date_time=>"2018-12-11T00:00:00.000Z", :dpo=>-28.722000000000037},
          {:date_time=>"2018-12-10T00:00:00.000Z", :dpo=>-29.836000000000013},
          {:date_time=>"2018-12-07T00:00:00.000Z", :dpo=>-33.321500000000015},
          {:date_time=>"2018-12-06T00:00:00.000Z", :dpo=>-29.007000000000033},
          {:date_time=>"2018-12-04T00:00:00.000Z", :dpo=>-29.3245},
          {:date_time=>"2018-12-03T00:00:00.000Z", :dpo=>-22.93399999999997},
          {:date_time=>"2018-11-30T00:00:00.000Z", :dpo=>-30.462999999999965},
          {:date_time=>"2018-11-29T00:00:00.000Z", :dpo=>-30.723499999999945},
          {:date_time=>"2018-11-28T00:00:00.000Z", :dpo=>-31.052999999999997},
          {:date_time=>"2018-11-27T00:00:00.000Z", :dpo=>-39.24899999999997},
          {:date_time=>"2018-11-26T00:00:00.000Z", :dpo=>-40.02850000000001},
          {:date_time=>"2018-11-23T00:00:00.000Z", :dpo=>-43.2405},
          {:date_time=>"2018-11-21T00:00:00.000Z", :dpo=>-39.04850000000002},
          {:date_time=>"2018-11-20T00:00:00.000Z", :dpo=>-39.16900000000004},
          {:date_time=>"2018-11-19T00:00:00.000Z", :dpo=>-31.444000000000017}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('dpo')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Detrended Price Oscillator')
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
        expect(indicator.min_data_size(options)).to eq(6)
      end
    end
  end
end
