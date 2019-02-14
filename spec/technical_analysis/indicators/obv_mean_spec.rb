require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "OBV Mean" do
    input_data = SpecHelper.get_test_data(:close, :volume)
    indicator = TechnicalAnalysis::ObvMean

    describe 'On-balance Volume Mean' do
      it 'Calculates OBV Mean (10 day)' do
        output = indicator.calculate(input_data, period: 10)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :obv_mean=>-642606913.0},
          {:date_time=>"2019-01-08T00:00:00.000Z", :obv_mean=>-654187384.0},
          {:date_time=>"2019-01-07T00:00:00.000Z", :obv_mean=>-657547495.0},
          {:date_time=>"2019-01-04T00:00:00.000Z", :obv_mean=>-647295525.0},
          {:date_time=>"2019-01-03T00:00:00.000Z", :obv_mean=>-636060876.0},
          {:date_time=>"2019-01-02T00:00:00.000Z", :obv_mean=>-614324095.0},
          {:date_time=>"2018-12-31T00:00:00.000Z", :obv_mean=>-605073347.0},
          {:date_time=>"2018-12-28T00:00:00.000Z", :obv_mean=>-587933850.0},
          {:date_time=>"2018-12-27T00:00:00.000Z", :obv_mean=>-563282378.0},
          {:date_time=>"2018-12-26T00:00:00.000Z", :obv_mean=>-537632267.0},
          {:date_time=>"2018-12-24T00:00:00.000Z", :obv_mean=>-520690509.0},
          {:date_time=>"2018-12-21T00:00:00.000Z", :obv_mean=>-493338562.0},
          {:date_time=>"2018-12-20T00:00:00.000Z", :obv_mean=>-475879438.0},
          {:date_time=>"2018-12-19T00:00:00.000Z", :obv_mean=>-463802236.0},
          {:date_time=>"2018-12-18T00:00:00.000Z", :obv_mean=>-453894366.0},
          {:date_time=>"2018-12-17T00:00:00.000Z", :obv_mean=>-444632138.0},
          {:date_time=>"2018-12-14T00:00:00.000Z", :obv_mean=>-436048331.0},
          {:date_time=>"2018-12-13T00:00:00.000Z", :obv_mean=>-427847140.0},
          {:date_time=>"2018-12-12T00:00:00.000Z", :obv_mean=>-419555627.0},
          {:date_time=>"2018-12-11T00:00:00.000Z", :obv_mean=>-412682868.0},
          {:date_time=>"2018-12-10T00:00:00.000Z", :obv_mean=>-398147027.0},
          {:date_time=>"2018-12-07T00:00:00.000Z", :obv_mean=>-392674222.0},
          {:date_time=>"2018-12-06T00:00:00.000Z", :obv_mean=>-378663120.0},
          {:date_time=>"2018-12-04T00:00:00.000Z", :obv_mean=>-365710262.0},
          {:date_time=>"2018-12-03T00:00:00.000Z", :obv_mean=>-350260027.0},
          {:date_time=>"2018-11-30T00:00:00.000Z", :obv_mean=>-334761235.0},
          {:date_time=>"2018-11-29T00:00:00.000Z", :obv_mean=>-318827806.0},
          {:date_time=>"2018-11-28T00:00:00.000Z", :obv_mean=>-311463969.0},
          {:date_time=>"2018-11-27T00:00:00.000Z", :obv_mean=>-302197756.0},
          {:date_time=>"2018-11-26T00:00:00.000Z", :obv_mean=>-283664797.0},
          {:date_time=>"2018-11-23T00:00:00.000Z", :obv_mean=>-264148349.0},
          {:date_time=>"2018-11-21T00:00:00.000Z", :obv_mean=>-236733893.0},
          {:date_time=>"2018-11-20T00:00:00.000Z", :obv_mean=>-209152907.0},
          {:date_time=>"2018-11-19T00:00:00.000Z", :obv_mean=>-188010709.0},
          {:date_time=>"2018-11-16T00:00:00.000Z", :obv_mean=>-176813851.0},
          {:date_time=>"2018-11-15T00:00:00.000Z", :obv_mean=>-163172458.0},
          {:date_time=>"2018-11-14T00:00:00.000Z", :obv_mean=>-136807276.0},
          {:date_time=>"2018-11-13T00:00:00.000Z", :obv_mean=>-111110335.0},
          {:date_time=>"2018-11-12T00:00:00.000Z", :obv_mean=>-95269809.0},
          {:date_time=>"2018-11-09T00:00:00.000Z", :obv_mean=>-87750647.0},
          {:date_time=>"2018-11-08T00:00:00.000Z", :obv_mean=>-80759219.0},
          {:date_time=>"2018-11-07T00:00:00.000Z", :obv_mean=>-72480397.0},
          {:date_time=>"2018-11-06T00:00:00.000Z", :obv_mean=>-69633236.0},
          {:date_time=>"2018-11-05T00:00:00.000Z", :obv_mean=>-59457699.0},
          {:date_time=>"2018-11-02T00:00:00.000Z", :obv_mean=>-49972807.0},
          {:date_time=>"2018-11-01T00:00:00.000Z", :obv_mean=>-49970286.0},
          {:date_time=>"2018-10-31T00:00:00.000Z", :obv_mean=>-62359854.0},
          {:date_time=>"2018-10-30T00:00:00.000Z", :obv_mean=>-66215087.0},
          {:date_time=>"2018-10-29T00:00:00.000Z", :obv_mean=>-63999351.0},
          {:date_time=>"2018-10-26T00:00:00.000Z", :obv_mean=>-61015077.0},
          {:date_time=>"2018-10-25T00:00:00.000Z", :obv_mean=>-59574127.0},
          {:date_time=>"2018-10-24T00:00:00.000Z", :obv_mean=>-66801824.0},
          {:date_time=>"2018-10-23T00:00:00.000Z", :obv_mean=>-65836555.0}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('obv_mean')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('On-balance Volume Mean')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period))
      end

      it 'Validates options' do
        valid_options = { period: 22 }
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
