require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "MFI" do
    input_data = SpecHelper.get_test_data(:high, :low, :close, :volume)
    indicator = TechnicalAnalysis::Mfi

    describe 'Money Flow Index' do
      it 'Calculates MFI (14 day)' do
        output = indicator.calculate(input_data, period: 14)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :mfi=>50.72343663578981},
          {:date_time=>"2019-01-08T00:00:00.000Z", :mfi=>50.1757147722236},
          {:date_time=>"2019-01-07T00:00:00.000Z", :mfi=>44.40424662233335},
          {:date_time=>"2019-01-04T00:00:00.000Z", :mfi=>37.81171947764313},
          {:date_time=>"2019-01-03T00:00:00.000Z", :mfi=>36.12141791144509},
          {:date_time=>"2019-01-02T00:00:00.000Z", :mfi=>44.40322811326429},
          {:date_time=>"2018-12-31T00:00:00.000Z", :mfi=>50.84666407662511},
          {:date_time=>"2018-12-28T00:00:00.000Z", :mfi=>43.66248537462054},
          {:date_time=>"2018-12-27T00:00:00.000Z", :mfi=>37.56125308902594},
          {:date_time=>"2018-12-26T00:00:00.000Z", :mfi=>30.54886108664553},
          {:date_time=>"2018-12-24T00:00:00.000Z", :mfi=>22.795547568232564},
          {:date_time=>"2018-12-21T00:00:00.000Z", :mfi=>29.111701049682864},
          {:date_time=>"2018-12-20T00:00:00.000Z", :mfi=>31.23926122664477},
          {:date_time=>"2018-12-19T00:00:00.000Z", :mfi=>39.506183778454634},
          {:date_time=>"2018-12-18T00:00:00.000Z", :mfi=>47.447534147092476},
          {:date_time=>"2018-12-17T00:00:00.000Z", :mfi=>48.23034273673764},
          {:date_time=>"2018-12-14T00:00:00.000Z", :mfi=>47.94902504034211},
          {:date_time=>"2018-12-13T00:00:00.000Z", :mfi=>49.219385053554596},
          {:date_time=>"2018-12-12T00:00:00.000Z", :mfi=>43.77747404533765},
          {:date_time=>"2018-12-11T00:00:00.000Z", :mfi=>35.65846689890073},
          {:date_time=>"2018-12-10T00:00:00.000Z", :mfi=>28.368262151706787},
          {:date_time=>"2018-12-07T00:00:00.000Z", :mfi=>36.043235982173},
          {:date_time=>"2018-12-06T00:00:00.000Z", :mfi=>43.83608665179891},
          {:date_time=>"2018-12-04T00:00:00.000Z", :mfi=>42.20999531156955},
          {:date_time=>"2018-12-03T00:00:00.000Z", :mfi=>41.56028762200471},
          {:date_time=>"2018-11-30T00:00:00.000Z", :mfi=>34.05798943239071},
          {:date_time=>"2018-11-29T00:00:00.000Z", :mfi=>34.06816082393442},
          {:date_time=>"2018-11-28T00:00:00.000Z", :mfi=>32.76065853310956},
          {:date_time=>"2018-11-27T00:00:00.000Z", :mfi=>31.964707056845796},
          {:date_time=>"2018-11-26T00:00:00.000Z", :mfi=>31.547361595662196},
          {:date_time=>"2018-11-23T00:00:00.000Z", :mfi=>30.0162422598642},
          {:date_time=>"2018-11-21T00:00:00.000Z", :mfi=>26.562703378271138},
          {:date_time=>"2018-11-20T00:00:00.000Z", :mfi=>33.960148214906965},
          {:date_time=>"2018-11-19T00:00:00.000Z", :mfi=>41.216526023725},
          {:date_time=>"2018-11-16T00:00:00.000Z", :mfi=>41.22749344358184},
          {:date_time=>"2018-11-15T00:00:00.000Z", :mfi=>35.21136683265594},
          {:date_time=>"2018-11-14T00:00:00.000Z", :mfi=>28.384945303826555},
          {:date_time=>"2018-11-13T00:00:00.000Z", :mfi=>34.34229761188338},
          {:date_time=>"2018-11-12T00:00:00.000Z", :mfi=>34.42914208336833},
          {:date_time=>"2018-11-09T00:00:00.000Z", :mfi=>34.82129345577579},
          {:date_time=>"2018-11-08T00:00:00.000Z", :mfi=>39.93886476277229},
          {:date_time=>"2018-11-07T00:00:00.000Z", :mfi=>40.83081970751587},
          {:date_time=>"2018-11-06T00:00:00.000Z", :mfi=>35.50426811855657},
          {:date_time=>"2018-11-05T00:00:00.000Z", :mfi=>34.78216906343063},
          {:date_time=>"2018-11-02T00:00:00.000Z", :mfi=>41.95906812943111},
          {:date_time=>"2018-11-01T00:00:00.000Z", :mfi=>46.69168911629936},
          {:date_time=>"2018-10-31T00:00:00.000Z", :mfi=>45.214622261116865},
          {:date_time=>"2018-10-30T00:00:00.000Z", :mfi=>36.38768375444253},
          {:date_time=>"2018-10-29T00:00:00.000Z", :mfi=>35.973926377719295}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+2)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('mfi')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Money Flow Index')
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
