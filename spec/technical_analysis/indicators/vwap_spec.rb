require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "VWAP" do
    input_data = SpecHelper.get_test_data(:volume, :high, :low, :close)
    indicator = TechnicalAnalysis::Vwap

    describe 'Volume Weighted Average Price' do
      it 'Calculates VWAP' do
        output = indicator.calculate(input_data)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :vwap=>183.55426863053765},
          {:date_time=>"2019-01-08T00:00:00.000Z", :vwap=>184.06635227887782},
          {:date_time=>"2019-01-07T00:00:00.000Z", :vwap=>184.57507590747517},
          {:date_time=>"2019-01-04T00:00:00.000Z", :vwap=>185.3413093796368},
          {:date_time=>"2019-01-03T00:00:00.000Z", :vwap=>186.19781421865375},
          {:date_time=>"2019-01-02T00:00:00.000Z", :vwap=>187.76843731172002},
          {:date_time=>"2018-12-31T00:00:00.000Z", :vwap=>188.21552447966795},
          {:date_time=>"2018-12-28T00:00:00.000Z", :vwap=>188.64862275471472},
          {:date_time=>"2018-12-27T00:00:00.000Z", :vwap=>189.2144975598256},
          {:date_time=>"2018-12-26T00:00:00.000Z", :vwap=>189.9889456493791},
          {:date_time=>"2018-12-24T00:00:00.000Z", :vwap=>190.91953458787302},
          {:date_time=>"2018-12-21T00:00:00.000Z", :vwap=>191.6297166885398},
          {:date_time=>"2018-12-20T00:00:00.000Z", :vwap=>193.36567531270202},
          {:date_time=>"2018-12-19T00:00:00.000Z", :vwap=>194.463693818502},
          {:date_time=>"2018-12-18T00:00:00.000Z", :vwap=>195.21670632642397},
          {:date_time=>"2018-12-17T00:00:00.000Z", :vwap=>195.7127882800064},
          {:date_time=>"2018-12-14T00:00:00.000Z", :vwap=>196.3956319251192},
          {:date_time=>"2018-12-13T00:00:00.000Z", :vwap=>197.03092567150182},
          {:date_time=>"2018-12-12T00:00:00.000Z", :vwap=>197.47196479514173},
          {:date_time=>"2018-12-11T00:00:00.000Z", :vwap=>198.00221355940155},
          {:date_time=>"2018-12-10T00:00:00.000Z", :vwap=>198.7429667210245},
          {:date_time=>"2018-12-07T00:00:00.000Z", :vwap=>199.85255982037654},
          {:date_time=>"2018-12-06T00:00:00.000Z", :vwap=>200.57927838438474},
          {:date_time=>"2018-12-04T00:00:00.000Z", :vwap=>201.28731920049952},
          {:date_time=>"2018-12-03T00:00:00.000Z", :vwap=>201.8731568533139},
          {:date_time=>"2018-11-30T00:00:00.000Z", :vwap=>202.34554208942396},
          {:date_time=>"2018-11-29T00:00:00.000Z", :vwap=>202.95867828112358},
          {:date_time=>"2018-11-28T00:00:00.000Z", :vwap=>203.60135199869035},
          {:date_time=>"2018-11-27T00:00:00.000Z", :vwap=>204.38651817163168},
          {:date_time=>"2018-11-26T00:00:00.000Z", :vwap=>205.30361785858756},
          {:date_time=>"2018-11-23T00:00:00.000Z", :vwap=>206.36274937523916},
          {:date_time=>"2018-11-21T00:00:00.000Z", :vwap=>206.94494917055295},
          {:date_time=>"2018-11-20T00:00:00.000Z", :vwap=>207.6427516507437},
          {:date_time=>"2018-11-19T00:00:00.000Z", :vwap=>209.27699957144853},
          {:date_time=>"2018-11-16T00:00:00.000Z", :vwap=>210.05211892678065},
          {:date_time=>"2018-11-15T00:00:00.000Z", :vwap=>210.59952347188045},
          {:date_time=>"2018-11-14T00:00:00.000Z", :vwap=>211.4589551886514},
          {:date_time=>"2018-11-13T00:00:00.000Z", :vwap=>212.75803369499064},
          {:date_time=>"2018-11-12T00:00:00.000Z", :vwap=>213.6551619737374},
          {:date_time=>"2018-11-09T00:00:00.000Z", :vwap=>214.61043573066618},
          {:date_time=>"2018-11-08T00:00:00.000Z", :vwap=>215.00076838969952},
          {:date_time=>"2018-11-07T00:00:00.000Z", :vwap=>215.18761540540189},
          {:date_time=>"2018-11-06T00:00:00.000Z", :vwap=>215.4663555747261},
          {:date_time=>"2018-11-05T00:00:00.000Z", :vwap=>215.93354729003553},
          {:date_time=>"2018-11-02T00:00:00.000Z", :vwap=>217.20680955786048},
          {:date_time=>"2018-11-01T00:00:00.000Z", :vwap=>218.35223508156088},
          {:date_time=>"2018-10-31T00:00:00.000Z", :vwap=>218.1692825392702},
          {:date_time=>"2018-10-30T00:00:00.000Z", :vwap=>218.13783195840017},
          {:date_time=>"2018-10-29T00:00:00.000Z", :vwap=>218.5155747290589},
          {:date_time=>"2018-10-26T00:00:00.000Z", :vwap=>219.05970452474796},
          {:date_time=>"2018-10-25T00:00:00.000Z", :vwap=>219.3440526461074},
          {:date_time=>"2018-10-24T00:00:00.000Z", :vwap=>219.34643675779574},
          {:date_time=>"2018-10-23T00:00:00.000Z", :vwap=>219.4951598586493},
          {:date_time=>"2018-10-22T00:00:00.000Z", :vwap=>219.41092910048724},
          {:date_time=>"2018-10-19T00:00:00.000Z", :vwap=>219.26375336145847},
          {:date_time=>"2018-10-18T00:00:00.000Z", :vwap=>219.25541442468506},
          {:date_time=>"2018-10-17T00:00:00.000Z", :vwap=>219.65735634491844},
          {:date_time=>"2018-10-16T00:00:00.000Z", :vwap=>219.5125052055069},
          {:date_time=>"2018-10-15T00:00:00.000Z", :vwap=>219.34283327445593},
          {:date_time=>"2018-10-12T00:00:00.000Z", :vwap=>219.44169580294155},
          {:date_time=>"2018-10-11T00:00:00.000Z", :vwap=>219.0592293697168},
          {:date_time=>"2018-10-10T00:00:00.000Z", :vwap=>221.89869420553177},
          {:date_time=>"2018-10-09T00:00:00.000Z", :vwap=>225.4620666666667}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate([])}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('vwap')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Volume Weighted Average Price')
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
        expect { indicator.validate_options(invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = {}
        expect(indicator.min_data_size(options)).to eq(1)
      end
    end
  end
end
