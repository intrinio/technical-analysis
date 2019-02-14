require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "OBV" do
    input_data = SpecHelper.get_test_data(:close, :volume)
    indicator = TechnicalAnalysis::Obv

    describe 'On-balance Volume' do
      it 'Calculates OBV' do
        output = indicator.calculate(input_data)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :obv=>-591085010},
          {:date_time=>"2019-01-08T00:00:00.000Z", :obv=>-636119380},
          {:date_time=>"2019-01-07T00:00:00.000Z", :obv=>-676742290},
          {:date_time=>"2019-01-04T00:00:00.000Z", :obv=>-622170850},
          {:date_time=>"2019-01-03T00:00:00.000Z", :obv=>-679594500},
          {:date_time=>"2019-01-02T00:00:00.000Z", :obv=>-588487660},
          {:date_time=>"2018-12-31T00:00:00.000Z", :obv=>-624124730},
          {:date_time=>"2018-12-28T00:00:00.000Z", :obv=>-658624120},
          {:date_time=>"2018-12-27T00:00:00.000Z", :obv=>-700364720},
          {:date_time=>"2018-12-26T00:00:00.000Z", :obv=>-648755870},
          {:date_time=>"2018-12-24T00:00:00.000Z", :obv=>-706889720},
          {:date_time=>"2018-12-21T00:00:00.000Z", :obv=>-669720490},
          {:date_time=>"2018-12-20T00:00:00.000Z", :obv=>-574222590},
          {:date_time=>"2018-12-19T00:00:00.000Z", :obv=>-509824360},
          {:date_time=>"2018-12-18T00:00:00.000Z", :obv=>-462226690},
          {:date_time=>"2018-12-17T00:00:00.000Z", :obv=>-495980180},
          {:date_time=>"2018-12-14T00:00:00.000Z", :obv=>-452729760},
          {:date_time=>"2018-12-13T00:00:00.000Z", :obv=>-412109400},
          {:date_time=>"2018-12-12T00:00:00.000Z", :obv=>-443863610},
          {:date_time=>"2018-12-11T00:00:00.000Z", :obv=>-479338290},
          {:date_time=>"2018-12-10T00:00:00.000Z", :obv=>-433370250},
          {:date_time=>"2018-12-07T00:00:00.000Z", :obv=>-495129250},
          {:date_time=>"2018-12-06T00:00:00.000Z", :obv=>-453450570},
          {:date_time=>"2018-12-04T00:00:00.000Z", :obv=>-410745660},
          {:date_time=>"2018-12-03T00:00:00.000Z", :obv=>-369604410},
          {:date_time=>"2018-11-30T00:00:00.000Z", :obv=>-410142110},
          {:date_time=>"2018-11-29T00:00:00.000Z", :obv=>-370717850},
          {:date_time=>"2018-11-28T00:00:00.000Z", :obv=>-329194270},
          {:date_time=>"2018-11-27T00:00:00.000Z", :obv=>-375136020},
          {:date_time=>"2018-11-26T00:00:00.000Z", :obv=>-333979880},
          {:date_time=>"2018-11-23T00:00:00.000Z", :obv=>-378642200},
          {:date_time=>"2018-11-21T00:00:00.000Z", :obv=>-355018230},
          {:date_time=>"2018-11-20T00:00:00.000Z", :obv=>-323921990},
          {:date_time=>"2018-11-19T00:00:00.000Z", :obv=>-256243310},
          {:date_time=>"2018-11-16T00:00:00.000Z", :obv=>-214616490},
          {:date_time=>"2018-11-15T00:00:00.000Z", :obv=>-250807820},
          {:date_time=>"2018-11-14T00:00:00.000Z", :obv=>-297079480},
          {:date_time=>"2018-11-13T00:00:00.000Z", :obv=>-236532140},
          {:date_time=>"2018-11-12T00:00:00.000Z", :obv=>-189806430},
          {:date_time=>"2018-11-09T00:00:00.000Z", :obv=>-138815400},
          {:date_time=>"2018-11-08T00:00:00.000Z", :obv=>-104497640},
          {:date_time=>"2018-11-07T00:00:00.000Z", :obv=>-79208370},
          {:date_time=>"2018-11-06T00:00:00.000Z", :obv=>-112500010},
          {:date_time=>"2018-11-05T00:00:00.000Z", :obv=>-144274730},
          {:date_time=>"2018-11-02T00:00:00.000Z", :obv=>-78202560},
          {:date_time=>"2018-11-01T00:00:00.000Z", :obv=>12844000},
          {:date_time=>"2018-10-31T00:00:00.000Z", :obv=>-40110070},
          {:date_time=>"2018-10-30T00:00:00.000Z", :obv=>-78126880},
          {:date_time=>"2018-10-29T00:00:00.000Z", :obv=>-114614810},
          {:date_time=>"2018-10-26T00:00:00.000Z", :obv=>-68901120},
          {:date_time=>"2018-10-25T00:00:00.000Z", :obv=>-21709420},
          {:date_time=>"2018-10-24T00:00:00.000Z", :obv=>-50736760},
          {:date_time=>"2018-10-23T00:00:00.000Z", :obv=>-10744640},
          {:date_time=>"2018-10-22T00:00:00.000Z", :obv=>-49425810},
          {:date_time=>"2018-10-19T00:00:00.000Z", :obv=>-78177350},
          {:date_time=>"2018-10-18T00:00:00.000Z", :obv=>-111051680},
          {:date_time=>"2018-10-17T00:00:00.000Z", :obv=>-78662400},
          {:date_time=>"2018-10-16T00:00:00.000Z", :obv=>-55969520},
          {:date_time=>"2018-10-15T00:00:00.000Z", :obv=>-84772070},
          {:date_time=>"2018-10-12T00:00:00.000Z", :obv=>-54491620},
          {:date_time=>"2018-10-11T00:00:00.000Z", :obv=>-93986390},
          {:date_time=>"2018-10-10T00:00:00.000Z", :obv=>-41084070},
          {:date_time=>"2018-10-09T00:00:00.000Z", :obv=>0}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate([])}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('obv')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('On-balance Volume')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq([])
      end

      it 'Validates options' do
        valid_options = {}
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = {}
        expect(indicator.min_data_size(options)).to eq(1)
      end
    end
  end
end
