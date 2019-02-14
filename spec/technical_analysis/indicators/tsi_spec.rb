require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "TSI" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Tsi

    describe 'True Strength Index' do
      it 'Calculates True Strength Index' do
        output = indicator.calculate(input_data, low_period: 13, high_period: 25, price_key: :close)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :tsi=>-28.91017661103889},
          {:date_time=>"2019-01-08T00:00:00.000Z", :tsi=>-30.97413963420104},
          {:date_time=>"2019-01-07T00:00:00.000Z", :tsi=>-32.39480993311267},
          {:date_time=>"2019-01-04T00:00:00.000Z", :tsi=>-32.874679857827935},
          {:date_time=>"2019-01-03T00:00:00.000Z", :tsi=>-33.579027007940994},
          {:date_time=>"2019-01-02T00:00:00.000Z", :tsi=>-31.495178028566524},
          {:date_time=>"2018-12-31T00:00:00.000Z", :tsi=>-32.785927300024994},
          {:date_time=>"2018-12-28T00:00:00.000Z", :tsi=>-34.28080772951784},
          {:date_time=>"2018-12-27T00:00:00.000Z", :tsi=>-35.41195667338275},
          {:date_time=>"2018-12-26T00:00:00.000Z", :tsi=>-36.802531445786066},
          {:date_time=>"2018-12-24T00:00:00.000Z", :tsi=>-38.83883734905748},
          {:date_time=>"2018-12-21T00:00:00.000Z", :tsi=>-36.202827241203856},
          {:date_time=>"2018-12-20T00:00:00.000Z", :tsi=>-33.78946079860395},
          {:date_time=>"2018-12-19T00:00:00.000Z", :tsi=>-32.23640227177938},
          {:date_time=>"2018-12-18T00:00:00.000Z", :tsi=>-31.30170501401141},
          {:date_time=>"2018-12-17T00:00:00.000Z", :tsi=>-31.403055885745307},
          {:date_time=>"2018-12-14T00:00:00.000Z", :tsi=>-30.569488217596724},
          {:date_time=>"2018-12-13T00:00:00.000Z", :tsi=>-29.91401235092671},
          {:date_time=>"2018-12-12T00:00:00.000Z", :tsi=>-30.375476807689427},
          {:date_time=>"2018-12-11T00:00:00.000Z", :tsi=>-30.15935663446155},
          {:date_time=>"2018-12-10T00:00:00.000Z", :tsi=>-29.704744795960114},
          {:date_time=>"2018-12-07T00:00:00.000Z", :tsi=>-29.357900955250976},
          {:date_time=>"2018-12-06T00:00:00.000Z", :tsi=>-28.4796578607378},
          {:date_time=>"2018-12-04T00:00:00.000Z", :tsi=>-28.752945178257534},
          {:date_time=>"2018-12-03T00:00:00.000Z", :tsi=>-29.524570107700253},
          {:date_time=>"2018-11-30T00:00:00.000Z", :tsi=>-32.212798598181024}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        low_period = 13
        high_period = 25
        size_limit = low_period + high_period - 1
        input_data = input_data.first(size_limit)

        expect {indicator.calculate(input_data, low_period: low_period, high_period: high_period, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('tsi')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('True Strength Index')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(low_period high_period price_key))
      end

      it 'Validates options' do
        valid_options = { low_period: 10, high_period: 20, price_key: :close }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { low_period: 10, high_period: 20 }
        expect(indicator.min_data_size(options)).to eq(30)
      end
    end
  end
end
