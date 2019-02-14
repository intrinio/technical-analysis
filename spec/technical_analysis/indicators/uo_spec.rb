require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "UO" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)
    indicator = TechnicalAnalysis::Uo

    describe 'Ultimate Oscillator' do
      it 'Calculates UO (5 day)' do
        output = indicator.calculate(input_data, short_period: 7, medium_period: 14, long_period: 28, short_weight: 4, medium_weight: 2, long_weight: 1)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :uo=>47.28872762629681},
          {:date_time=>"2019-01-08T00:00:00.000Z", :uo=>44.828908983561035},
          {:date_time=>"2019-01-07T00:00:00.000Z", :uo=>46.58165158841807},
          {:date_time=>"2019-01-04T00:00:00.000Z", :uo=>50.726610056055335},
          {:date_time=>"2019-01-03T00:00:00.000Z", :uo=>43.660461129633255},
          {:date_time=>"2019-01-02T00:00:00.000Z", :uo=>51.63477005783912},
          {:date_time=>"2018-12-31T00:00:00.000Z", :uo=>46.12625788315007},
          {:date_time=>"2018-12-28T00:00:00.000Z", :uo=>44.736408028234784},
          {:date_time=>"2018-12-27T00:00:00.000Z", :uo=>44.80062908207362},
          {:date_time=>"2018-12-26T00:00:00.000Z", :uo=>38.89197235556109},
          {:date_time=>"2018-12-24T00:00:00.000Z", :uo=>24.01487703769969},
          {:date_time=>"2018-12-21T00:00:00.000Z", :uo=>28.31825074884628},
          {:date_time=>"2018-12-20T00:00:00.000Z", :uo=>30.219780692869403},
          {:date_time=>"2018-12-19T00:00:00.000Z", :uo=>31.693410049073588},
          {:date_time=>"2018-12-18T00:00:00.000Z", :uo=>42.6017793901735},
          {:date_time=>"2018-12-17T00:00:00.000Z", :uo=>38.091246151228205},
          {:date_time=>"2018-12-14T00:00:00.000Z", :uo=>43.99139965247388},
          {:date_time=>"2018-12-13T00:00:00.000Z", :uo=>42.5926187322538},
          {:date_time=>"2018-12-12T00:00:00.000Z", :uo=>46.56343334880161},
          {:date_time=>"2018-12-11T00:00:00.000Z", :uo=>47.39018769748099},
          {:date_time=>"2018-12-10T00:00:00.000Z", :uo=>46.78620949538559},
          {:date_time=>"2018-12-07T00:00:00.000Z", :uo=>46.3795568325064},
          {:date_time=>"2018-12-06T00:00:00.000Z", :uo=>54.531561679403225},
          {:date_time=>"2018-12-04T00:00:00.000Z", :uo=>54.53131218526129},
          {:date_time=>"2018-12-03T00:00:00.000Z", :uo=>58.63742128493122},
          {:date_time=>"2018-11-30T00:00:00.000Z", :uo=>48.76091038333585},
          {:date_time=>"2018-11-29T00:00:00.000Z", :uo=>42.75825214517756},
          {:date_time=>"2018-11-28T00:00:00.000Z", :uo=>39.6100967511459},
          {:date_time=>"2018-11-27T00:00:00.000Z", :uo=>36.448196445521205},
          {:date_time=>"2018-11-26T00:00:00.000Z", :uo=>37.129780535443615},
          {:date_time=>"2018-11-23T00:00:00.000Z", :uo=>30.31628731487427},
          {:date_time=>"2018-11-21T00:00:00.000Z", :uo=>30.12209085444982},
          {:date_time=>"2018-11-20T00:00:00.000Z", :uo=>29.938582222468735},
          {:date_time=>"2018-11-19T00:00:00.000Z", :uo=>33.50557345611348},
          {:date_time=>"2018-11-16T00:00:00.000Z", :uo=>37.48593642184523}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, long_period: input_data.size+2)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('uo')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Ultimate Oscillator')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(short_period medium_period long_period short_weight medium_weight long_weight))
      end

      it 'Validates options' do
        valid_options = { short_period: 7, medium_period: 14, long_period: 28, short_weight: 4, medium_weight: 2, long_weight: 1 }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { short_period: 7, medium_period: 14, long_period: 20, short_weight: 4, medium_weight: 2, long_weight: 1 }
        expect(indicator.min_data_size(options)).to eq(21)
      end
    end
  end
end
