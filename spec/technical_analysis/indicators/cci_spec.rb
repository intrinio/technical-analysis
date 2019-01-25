require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "CCI" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)

    describe 'Commodity Channel Index' do
      it 'Calculates CCI (20 day)' do
        output = TechnicalAnalysis::Cci.calculate(input_data, period: 20, constant: 0.015)

        expected_output = [
          {:date=>"2018/11/05", :value=>-281.5255251804358},
          {:date=>"2018/11/06", :value=>-198.71238766942466},
          {:date=>"2018/11/07", :value=>-107.40409620543349},
          {:date=>"2018/11/08", :value=>-88.26723659204252},
          {:date=>"2018/11/09", :value=>-121.3842764199079},
          {:date=>"2018/11/12", :value=>-179.88996064655686},
          {:date=>"2018/11/13", :value=>-170.11758119513328},
          {:date=>"2018/11/14", :value=>-176.53554346437872},
          {:date=>"2018/11/15", :value=>-144.29736082195598},
          {:date=>"2018/11/16", :value=>-109.8703962546515},
          {:date=>"2018/11/19", :value=>-129.79321417259732},
          {:date=>"2018/11/20", :value=>-166.092016017792},
          {:date=>"2018/11/21", :value=>-143.70909871161282},
          {:date=>"2018/11/23", :value=>-145.81148745067057},
          {:date=>"2018/11/26", :value=>-130.57777507098388},
          {:date=>"2018/11/27", :value=>-117.06521007698558},
          {:date=>"2018/11/28", :value=>-79.16162769465076},
          {:date=>"2018/11/29", :value=>-67.42425893465922},
          {:date=>"2018/11/30", :value=>-68.8774176049022},
          {:date=>"2018/12/03", :value=>-32.43699792850786},
          {:date=>"2018/12/04", :value=>-60.69535791887537},
          {:date=>"2018/12/06", :value=>-87.66403875835518},
          {:date=>"2018/12/07", :value=>-102.13101656480995},
          {:date=>"2018/12/10", :value=>-118.83020945347108},
          {:date=>"2018/12/11", :value=>-105.1287325078536},
          {:date=>"2018/12/12", :value=>-93.5619842292165},
          {:date=>"2018/12/13", :value=>-77.37092752385674},
          {:date=>"2018/12/14", :value=>-114.79798652194032},
          {:date=>"2018/12/17", :value=>-123.22931274779911},
          {:date=>"2018/12/18", :value=>-108.36683776743406},
          {:date=>"2018/12/19", :value=>-145.86611021295013},
          {:date=>"2018/12/20", :value=>-175.655233047097},
          {:date=>"2018/12/21", :value=>-204.3001270602558},
          {:date=>"2018/12/24", :value=>-205.86763488625635},
          {:date=>"2018/12/26", :value=>-130.89740843118958},
          {:date=>"2018/12/27", :value=>-109.82143904961333},
          {:date=>"2018/12/28", :value=>-82.72457326337747},
          {:date=>"2018/12/31", :value=>-62.94237272962061},
          {:date=>"2019/01/02", :value=>-62.42850721332871},
          {:date=>"2019/01/03", :value=>-162.69069349674928},
          {:date=>"2019/01/04", :value=>-119.01911861945885},
          {:date=>"2019/01/07", :value=>-103.45330536502108},
          {:date=>"2019/01/08", :value=>-72.7408611895969},
          {:date=>"2019/01/09", :value=>-48.14847062019609}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Cci.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
