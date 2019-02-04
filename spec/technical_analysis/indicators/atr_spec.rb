require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "ATR" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)
    indicator = TechnicalAnalysis::Atr

    describe 'Average True Range' do
      it 'Calculates ATR (14 day)' do
        output = indicator.calculate(input_data, period: 14)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>6.103013600253306},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>6.195553107965099},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>6.3729033470393395},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>6.637742066042365},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>6.6591145326610075},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>5.946738727481086},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>6.048795552671939},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>6.273318287492855},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>6.450496617299998},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>6.400534818630767},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>6.084422112371596},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>6.170916121015564},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>5.989448130324453},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>5.926328755734025},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>5.739123275405874},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>5.904440450437095},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>5.926320485086102},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>5.946037445477343},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>6.1365018643602145},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>6.355463546234078},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>6.475883819021315},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>6.4540287281768025},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>6.456646322651943},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>6.471003732086706},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>6.311080942247224},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>6.307317937804704},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>6.538650086866604},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>6.649315478164034},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>6.618493591868961},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>6.828377714320418},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>6.9928683077296805},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>7.1707812544781175},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>7.43622596636105},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>7.212089502234975},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>7.109942540868436},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>7.233053505550622},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>7.391749929054517},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>7.302653769751019},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>7.423634828962634},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>7.173145200421298},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>7.244925600453705},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>7.542996800488605},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>7.63938116975696},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>7.98625664435365},
          {:date_time=>"2018-11-02T00:00:00.000Z", :value=>7.884430232380852},
          {:date_time=>"2018-11-01T00:00:00.000Z", :value=>7.199386404102457},
          {:date_time=>"2018-10-31T00:00:00.000Z", :value=>7.326262281341107},
          {:date_time=>"2018-10-30T00:00:00.000Z", :value=>7.339820918367347},
          {:date_time=>"2018-10-29T00:00:00.000Z", :value=>7.449807142857144}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('atr')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Average True Range')
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
