require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "CCI" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)
    indicator = TechnicalAnalysis::Cci

    describe 'Commodity Channel Index' do
      it 'Calculates CCI (20 day)' do
        output = indicator.calculate(input_data, period: 20, constant: 0.015)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :cci=>-48.14847062019609},
          {:date_time=>"2019-01-08T00:00:00.000Z", :cci=>-72.7408611895969},
          {:date_time=>"2019-01-07T00:00:00.000Z", :cci=>-103.45330536502108},
          {:date_time=>"2019-01-04T00:00:00.000Z", :cci=>-119.01911861945885},
          {:date_time=>"2019-01-03T00:00:00.000Z", :cci=>-162.69069349674928},
          {:date_time=>"2019-01-02T00:00:00.000Z", :cci=>-62.42850721332871},
          {:date_time=>"2018-12-31T00:00:00.000Z", :cci=>-62.94237272962061},
          {:date_time=>"2018-12-28T00:00:00.000Z", :cci=>-82.72457326337747},
          {:date_time=>"2018-12-27T00:00:00.000Z", :cci=>-109.82143904961333},
          {:date_time=>"2018-12-26T00:00:00.000Z", :cci=>-130.89740843118958},
          {:date_time=>"2018-12-24T00:00:00.000Z", :cci=>-205.86763488625635},
          {:date_time=>"2018-12-21T00:00:00.000Z", :cci=>-204.3001270602558},
          {:date_time=>"2018-12-20T00:00:00.000Z", :cci=>-175.655233047097},
          {:date_time=>"2018-12-19T00:00:00.000Z", :cci=>-145.86611021295013},
          {:date_time=>"2018-12-18T00:00:00.000Z", :cci=>-108.36683776743406},
          {:date_time=>"2018-12-17T00:00:00.000Z", :cci=>-123.22931274779911},
          {:date_time=>"2018-12-14T00:00:00.000Z", :cci=>-114.79798652194032},
          {:date_time=>"2018-12-13T00:00:00.000Z", :cci=>-77.37092752385674},
          {:date_time=>"2018-12-12T00:00:00.000Z", :cci=>-93.5619842292165},
          {:date_time=>"2018-12-11T00:00:00.000Z", :cci=>-105.1287325078536},
          {:date_time=>"2018-12-10T00:00:00.000Z", :cci=>-118.83020945347108},
          {:date_time=>"2018-12-07T00:00:00.000Z", :cci=>-102.13101656480995},
          {:date_time=>"2018-12-06T00:00:00.000Z", :cci=>-87.66403875835518},
          {:date_time=>"2018-12-04T00:00:00.000Z", :cci=>-60.69535791887537},
          {:date_time=>"2018-12-03T00:00:00.000Z", :cci=>-32.43699792850786},
          {:date_time=>"2018-11-30T00:00:00.000Z", :cci=>-68.8774176049022},
          {:date_time=>"2018-11-29T00:00:00.000Z", :cci=>-67.42425893465922},
          {:date_time=>"2018-11-28T00:00:00.000Z", :cci=>-79.16162769465076},
          {:date_time=>"2018-11-27T00:00:00.000Z", :cci=>-117.06521007698558},
          {:date_time=>"2018-11-26T00:00:00.000Z", :cci=>-130.57777507098388},
          {:date_time=>"2018-11-23T00:00:00.000Z", :cci=>-145.81148745067057},
          {:date_time=>"2018-11-21T00:00:00.000Z", :cci=>-143.70909871161282},
          {:date_time=>"2018-11-20T00:00:00.000Z", :cci=>-166.092016017792},
          {:date_time=>"2018-11-19T00:00:00.000Z", :cci=>-129.79321417259732},
          {:date_time=>"2018-11-16T00:00:00.000Z", :cci=>-109.8703962546515},
          {:date_time=>"2018-11-15T00:00:00.000Z", :cci=>-144.29736082195598},
          {:date_time=>"2018-11-14T00:00:00.000Z", :cci=>-176.53554346437872},
          {:date_time=>"2018-11-13T00:00:00.000Z", :cci=>-170.11758119513328},
          {:date_time=>"2018-11-12T00:00:00.000Z", :cci=>-179.88996064655686},
          {:date_time=>"2018-11-09T00:00:00.000Z", :cci=>-121.3842764199079},
          {:date_time=>"2018-11-08T00:00:00.000Z", :cci=>-88.26723659204252},
          {:date_time=>"2018-11-07T00:00:00.000Z", :cci=>-107.40409620543349},
          {:date_time=>"2018-11-06T00:00:00.000Z", :cci=>-198.71238766942466},
          {:date_time=>"2018-11-05T00:00:00.000Z", :cci=>-281.5255251804358}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('cci')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Commodity Channel Index')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period constant))
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
        expect(indicator.min_data_size(options)).to eq(4)
      end
    end
  end
end
