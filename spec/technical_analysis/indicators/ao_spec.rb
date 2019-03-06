require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "AO" do
    input_data = SpecHelper.get_test_data(:high, :low)
    indicator = TechnicalAnalysis::Ao

    describe 'Awesome Oscillator' do
      it 'Calculates AO (5 day short period, 34 day long period)' do
        output = indicator.calculate(input_data, short_period: 5, long_period: 34)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :ao=>-17.518757058823525},
          {:date_time=>"2019-01-08T00:00:00.000Z", :ao=>-17.8071908823529},
          {:date_time=>"2019-01-07T00:00:00.000Z", :ao=>-17.41204382352936},
          {:date_time=>"2019-01-04T00:00:00.000Z", :ao=>-16.838043823529347},
          {:date_time=>"2019-01-03T00:00:00.000Z", :ao=>-16.804919117647017},
          {:date_time=>"2019-01-02T00:00:00.000Z", :ao=>-16.73956617647059},
          {:date_time=>"2018-12-31T00:00:00.000Z", :ao=>-19.633272058823536},
          {:date_time=>"2018-12-28T00:00:00.000Z", :ao=>-21.924007352941203},
          {:date_time=>"2018-12-27T00:00:00.000Z", :ao=>-22.97706617647063},
          {:date_time=>"2018-12-26T00:00:00.000Z", :ao=>-22.471330882352987},
          {:date_time=>"2018-12-24T00:00:00.000Z", :ao=>-21.124477941176536},
          {:date_time=>"2018-12-21T00:00:00.000Z", :ao=>-19.609007352941205},
          {:date_time=>"2018-12-20T00:00:00.000Z", :ao=>-18.88406617647061},
          {:date_time=>"2018-12-19T00:00:00.000Z", :ao=>-18.17277205882357},
          {:date_time=>"2018-12-18T00:00:00.000Z", :ao=>-18.17262500000004},
          {:date_time=>"2018-12-17T00:00:00.000Z", :ao=>-18.865919117647138},
          {:date_time=>"2018-12-14T00:00:00.000Z", :ao=>-20.12868382352943},
          {:date_time=>"2018-12-13T00:00:00.000Z", :ao=>-20.811713235294178},
          {:date_time=>"2018-12-12T00:00:00.000Z", :ao=>-21.92503676470585},
          {:date_time=>"2018-12-11T00:00:00.000Z", :ao=>-21.579664411764696},
          {:date_time=>"2018-12-10T00:00:00.000Z", :ao=>-20.365870294117656},
          {:date_time=>"2018-12-07T00:00:00.000Z", :ao=>-19.51995852941178},
          {:date_time=>"2018-12-06T00:00:00.000Z", :ao=>-19.071752647058815},
          {:date_time=>"2018-12-04T00:00:00.000Z", :ao=>-19.392987941176415},
          {:date_time=>"2018-12-03T00:00:00.000Z", :ao=>-21.886519117646998},
          {:date_time=>"2018-11-30T00:00:00.000Z", :ao=>-25.05331323529407},
          {:date_time=>"2018-11-29T00:00:00.000Z", :ao=>-27.130989705882314},
          {:date_time=>"2018-11-28T00:00:00.000Z", :ao=>-28.547813235294086},
          {:date_time=>"2018-11-27T00:00:00.000Z", :ao=>-29.739166176470576},
          {:date_time=>"2018-11-26T00:00:00.000Z", :ao=>-28.26261029411762}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, long_period: input_data.size+1)}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('ao')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Awesome Oscillator')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(short_period long_period))
      end

      it 'Validates options' do
        valid_options = { short_period: 5, long_period: 34 }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { long_period: 20 }
        expect(indicator.min_data_size(options)).to eq(20)
      end
    end
  end
end
