require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "DPO" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Detrended Price Oscillator' do
      it 'Calculates DPO (20 day)' do
        output = TechnicalAnalysis::Dpo.calculate(input_data, period: 20, price_key: :close)

        expected_output = [
          {:date=>"2018/11/19", :value=>-31.444000000000017},
          {:date=>"2018/11/20", :value=>-39.16900000000004},
          {:date=>"2018/11/21", :value=>-39.04850000000002},
          {:date=>"2018/11/23", :value=>-43.2405},
          {:date=>"2018/11/26", :value=>-40.02850000000001},
          {:date=>"2018/11/27", :value=>-39.24899999999997},
          {:date=>"2018/11/28", :value=>-31.052999999999997},
          {:date=>"2018/11/29", :value=>-30.723499999999945},
          {:date=>"2018/11/30", :value=>-30.462999999999965},
          {:date=>"2018/12/03", :value=>-22.93399999999997},
          {:date=>"2018/12/04", :value=>-29.3245},
          {:date=>"2018/12/06", :value=>-29.007000000000033},
          {:date=>"2018/12/07", :value=>-33.321500000000015},
          {:date=>"2018/12/10", :value=>-29.836000000000013},
          {:date=>"2018/12/11", :value=>-28.722000000000037},
          {:date=>"2018/12/12", :value=>-26.35200000000006},
          {:date=>"2018/12/13", :value=>-22.884000000000043},
          {:date=>"2018/12/14", :value=>-26.388500000000022},
          {:date=>"2018/12/17", :value=>-25.746500000000054},
          {:date=>"2018/12/18", :value=>-22.48350000000005},
          {:date=>"2018/12/19", :value=>-26.41850000000005},
          {:date=>"2018/12/20", :value=>-29.025999999999982},
          {:date=>"2018/12/21", :value=>-33.053},
          {:date=>"2018/12/24", :value=>-35.0085},
          {:date=>"2018/12/26", :value=>-22.876499999999993},
          {:date=>"2018/12/27", :value=>-22.642999999999972},
          {:date=>"2018/12/28", :value=>-21.498999999999995},
          {:date=>"2018/12/31", :value=>-18.922999999999973},
          {:date=>"2019/01/02", :value=>-17.36949999999996},
          {:date=>"2019/01/03", :value=>-31.726499999999987},
          {:date=>"2019/01/04", :value=>-24.407999999999987},
          {:date=>"2019/01/07", :value=>-23.730500000000006},
          {:date=>"2019/01/08", :value=>-19.607999999999976},
          {:date=>"2019/01/09", :value=>-15.774999999999977}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Dpo.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
