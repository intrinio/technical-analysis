require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "SMA" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Simple Moving Average' do
      it 'Calculates SMA (5 day)' do
        output = TechnicalAnalysis::Sma.calculate(input_data, period: 5, price_key: :close)

        expected_output = [
          {:date=>"2018/10/15", :value=>219.43},
          {:date=>"2018/10/16", :value=>218.48600000000002},
          {:date=>"2018/10/17", :value=>219.452},
          {:date=>"2018/10/18", :value=>219.766},
          {:date=>"2018/10/19", :value=>219.206},
          {:date=>"2018/10/22", :value=>219.86400000000003},
          {:date=>"2018/10/23", :value=>219.97999999999996},
          {:date=>"2018/10/24", :value=>218.76},
          {:date=>"2018/10/25", :value=>219.51600000000002},
          {:date=>"2018/10/26", :value=>218.914},
          {:date=>"2018/10/29", :value=>217.23200000000003},
          {:date=>"2018/10/30", :value=>215.346},
          {:date=>"2018/10/31", :value=>216.1},
          {:date=>"2018/11/01", :value=>216.584},
          {:date=>"2018/11/02", :value=>214.82000000000002},
          {:date=>"2018/11/05", :value=>212.69},
          {:date=>"2018/11/06", :value=>210.78400000000002},
          {:date=>"2018/11/07", :value=>209.002},
          {:date=>"2018/11/08", :value=>206.256},
          {:date=>"2018/11/09", :value=>205.654},
          {:date=>"2018/11/12", :value=>204.17000000000002},
          {:date=>"2018/11/13", :value=>201.862},
          {:date=>"2018/11/14", :value=>197.23200000000003},
          {:date=>"2018/11/15", :value=>193.816},
          {:date=>"2018/11/16", :value=>191.628},
          {:date=>"2018/11/19", :value=>189.96599999999998},
          {:date=>"2018/11/20", :value=>186.916},
          {:date=>"2018/11/21", :value=>184.91199999999998},
          {:date=>"2018/11/23", :value=>181.088},
          {:date=>"2018/11/26", :value=>177.30599999999998},
          {:date=>"2018/11/27", :value=>174.982},
          {:date=>"2018/11/28", :value=>175.77400000000003},
          {:date=>"2018/11/29", :value=>176.32799999999997},
          {:date=>"2018/11/30", :value=>177.58599999999998},
          {:date=>"2018/12/03", :value=>179.62600000000003},
          {:date=>"2018/12/04", :value=>180.11600000000004},
          {:date=>"2018/12/06", :value=>178.872},
          {:date=>"2018/12/07", :value=>176.66},
          {:date=>"2018/12/10", :value=>174.864},
          {:date=>"2018/12/11", :value=>171.626},
          {:date=>"2018/12/12", :value=>170.108},
          {:date=>"2018/12/13", :value=>169.35399999999998},
          {:date=>"2018/12/14", :value=>168.752},
          {:date=>"2018/12/17", :value=>167.61999999999998},
          {:date=>"2018/12/18", :value=>167.108},
          {:date=>"2018/12/19", :value=>165.46599999999998},
          {:date=>"2018/12/20", :value=>162.642},
          {:date=>"2018/12/21", :value=>159.692},
          {:date=>"2018/12/24", :value=>156.27},
          {:date=>"2018/12/26", :value=>154.49},
          {:date=>"2018/12/27", :value=>153.54199999999997},
          {:date=>"2018/12/28", :value=>153.422},
          {:date=>"2018/12/31", :value=>154.824},
          {:date=>"2019/01/02", :value=>157.04199999999997},
          {:date=>"2019/01/03", :value=>154.046},
          {:date=>"2019/01/04", :value=>152.468},
          {:date=>"2019/01/07", :value=>150.808},
          {:date=>"2019/01/08", :value=>149.41},
          {:date=>"2019/01/09", :value=>148.488}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Sma.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
