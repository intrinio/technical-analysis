require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "CCI" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)

    describe 'Commodity Channel Index' do
      it 'Calculates CCI (20 day)' do
        output = TechnicalAnalysis::Cci.calculate(input_data, period: 20, constant: 0.015)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>-48.14847062019609},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>-72.7408611895969},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>-103.45330536502108},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>-119.01911861945885},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>-162.69069349674928},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>-62.42850721332871},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>-62.94237272962061},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>-82.72457326337747},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>-109.82143904961333},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>-130.89740843118958},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>-205.86763488625635},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>-204.3001270602558},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>-175.655233047097},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>-145.86611021295013},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>-108.36683776743406},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>-123.22931274779911},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>-114.79798652194032},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>-77.37092752385674},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>-93.5619842292165},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>-105.1287325078536},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>-118.83020945347108},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>-102.13101656480995},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>-87.66403875835518},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>-60.69535791887537},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>-32.43699792850786},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>-68.8774176049022},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>-67.42425893465922},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>-79.16162769465076},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>-117.06521007698558},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>-130.57777507098388},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>-145.81148745067057},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>-143.70909871161282},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>-166.092016017792},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>-129.79321417259732},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>-109.8703962546515},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>-144.29736082195598},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>-176.53554346437872},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>-170.11758119513328},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>-179.88996064655686},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>-121.3842764199079},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>-88.26723659204252},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>-107.40409620543349},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>-198.71238766942466},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>-281.5255251804358}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Cci.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
