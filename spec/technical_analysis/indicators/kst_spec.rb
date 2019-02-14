require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "KST" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Kst

    describe 'Know Sure Thing' do
      it 'Calculates KST' do
        output = indicator.calculate(input_data, roc1: 10, roc2: 15, roc3: 20, roc4: 30, sma1: 10, sma2: 10, sma3: 10, sma4: 15, price_key: :close)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :kst=>-140.9140022298261},
          {:date_time=>"2019-01-08T00:00:00.000Z", :kst=>-148.9261153101682},
          {:date_time=>"2019-01-07T00:00:00.000Z", :kst=>-155.71040741442587},
          {:date_time=>"2019-01-04T00:00:00.000Z", :kst=>-157.83675223915662},
          {:date_time=>"2019-01-03T00:00:00.000Z", :kst=>-157.0260814891967},
          {:date_time=>"2019-01-02T00:00:00.000Z", :kst=>-150.77021075475108},
          {:date_time=>"2018-12-31T00:00:00.000Z", :kst=>-152.43337072156913},
          {:date_time=>"2018-12-28T00:00:00.000Z", :kst=>-154.278039839607},
          {:date_time=>"2018-12-27T00:00:00.000Z", :kst=>-152.69243922992774},
          {:date_time=>"2018-12-26T00:00:00.000Z", :kst=>-151.25248412993977},
          {:date_time=>"2018-12-24T00:00:00.000Z", :kst=>-150.769274028613},
          {:date_time=>"2018-12-21T00:00:00.000Z", :kst=>-145.9029270207904},
          {:date_time=>"2018-12-20T00:00:00.000Z", :kst=>-143.4025404878081},
          {:date_time=>"2018-12-19T00:00:00.000Z", :kst=>-141.34365936138443},
          {:date_time=>"2018-12-18T00:00:00.000Z", :kst=>-141.36803679622636},
          {:date_time=>"2018-12-17T00:00:00.000Z", :kst=>-140.69442915235626},
          {:date_time=>"2018-12-14T00:00:00.000Z", :kst=>-141.6235541026754},
          {:date_time=>"2018-12-13T00:00:00.000Z", :kst=>-143.06704590371226},
          {:date_time=>"2018-12-12T00:00:00.000Z", :kst=>-146.67417088368043},
          {:date_time=>"2018-12-11T00:00:00.000Z", :kst=>-150.14198896419614}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        roc4 = 60
        sma4 = 30
        expect {indicator.calculate(input_data, roc4: roc4, sma4: sma4, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('kst')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Know Sure Thing')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period roc1 roc2 roc3 roc4 sma1 sma2 sma3 sma4 price_key))
      end

      it 'Validates options' do
        valid_options = { roc1: 10, roc2: 15, roc3: 20, roc4: 30, sma1: 10, sma2: 10, sma3: 10, sma4: 15, price_key: :kst }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { roc4: 30, sma4: 15 }
        expect(indicator.min_data_size(options)).to eq(44)
      end
    end
  end
end
