require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "VPT" do
    input_data = SpecHelper.get_test_data(:close, :volume)
    indicator = TechnicalAnalysis::Vpt

    describe 'Volume-Price Trend' do
      it 'Calculates VPT' do
        output = indicator.calculate(input_data)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>-27383899.78109331},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>-28148662.548589166},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>-28923059.940598898},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>-28801593.76496151},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>-31252972.592586517},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>-22178057.48873647},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>-22218723.601326805},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>-22552168.387219403},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>-22573553.26073845},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>-22238622.758734256},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>-26332500.093066465},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>-25370780.481841102},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>-21656330.504158247},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>-20031264.8456338},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>-18546614.21276814},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>-18985158.397835847},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>-18582658.71932485},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>-17282902.245502096},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>-17630301.940948576},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>-17729175.804436687},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>-17466268.97188952},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>-17873132.82137613},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>-16386993.991247926},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>-15910856.843135413},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>-14101104.854714246},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>-15517586.252407152},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>-15304600.832189944},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>-14985612.348714761},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>-16752197.088154612},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>-16662634.99217477},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>-17266635.256844807},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>-16666614.749434467},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>-16631473.78435367},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>-13397928.75906581},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>-11748170.533467716},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>-12149014.896876106},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>-13290943.979317216},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>-11580638.32359231},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>-11113790.317206156},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>-8545161.134440955},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>-7883463.234301859},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>-7707600.723227796},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>-8717279.945880784},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>-9060892.67270255},
          {:date_time=>"2018-11-02T00:00:00.000Z", :value=>-7185217.517024899},
          {:date_time=>"2018-11-01T00:00:00.000Z", :value=>-1146038.8004377298},
          {:date_time=>"2018-10-31T00:00:00.000Z", :value=>-1959004.510023763},
          {:date_time=>"2018-10-30T00:00:00.000Z", :value=>-2949972.4593908517},
          {:date_time=>"2018-10-29T00:00:00.000Z", :value=>-3132205.8074873467},
          {:date_time=>"2018-10-26T00:00:00.000Z", :value=>-2274149.490335243},
          {:date_time=>"2018-10-25T00:00:00.000Z", :value=>-1522689.2992524402},
          {:date_time=>"2018-10-24T00:00:00.000Z", :value=>-2158324.481734193},
          {:date_time=>"2018-10-23T00:00:00.000Z", :value=>-786529.9466468699},
          {:date_time=>"2018-10-22T00:00:00.000Z", :value=>-1151165.4943468445},
          {:date_time=>"2018-10-19T00:00:00.000Z", :value=>-1326839.4882367724},
          {:date_time=>"2018-10-18T00:00:00.000Z", :value=>-1827517.8777377433},
          {:date_time=>"2018-10-17T00:00:00.000Z", :value=>-1070464.7668376141},
          {:date_time=>"2018-10-16T00:00:00.000Z", :value=>-972399.6540759658},
          {:date_time=>"2018-10-15T00:00:00.000Z", :value=>-1607126.441433344},
          {:date_time=>"2018-10-12T00:00:00.000Z", :value=>-959554.7990039173},
          {:date_time=>"2018-10-11T00:00:00.000Z", :value=>-2370279.621573285},
          {:date_time=>"2018-10-10T00:00:00.000Z", :value=>-1903264.3174505206}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate([])}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('vpt')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Volume-price Trend')
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
        expect(indicator.min_data_size(options)).to eq(2)
      end
    end
  end
end
