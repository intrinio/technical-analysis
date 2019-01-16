require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "RSI" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Relative Strength Index' do
      it 'Calculates RSI (14 day)' do
        output = TechnicalAnalysis::Rsi.calculate(input_data, period: 14, price_key: :close)

        expected_output = [
          {:date=>"2018/12/19", :value=>30.416532991054595},
          {:date=>"2018/12/20", :value=>27.973957664061984},
          {:date=>"2018/12/21", :value=>24.757134961511937},
          {:date=>"2018/12/24", :value=>22.94077952430888},
          {:date=>"2018/12/26", :value=>36.28727515078207},
          {:date=>"2018/12/27", :value=>35.63166885267985},
          {:date=>"2018/12/28", :value=>35.7297472286003},
          {:date=>"2018/12/31", :value=>37.66054013673465} ,
          {:date=>"2019/01/02", :value=>37.90003559360193},
          {:date=>"2019/01/03", :value=>27.835833051062522},
          {:date=>"2019/01/04", :value=>35.00790948034705},
          {:date=>"2019/01/07", :value=>34.80538400125879},
          {:date=>"2019/01/08", :value=>38.100858593859655},
          {:date=>"2019/01/09", :value=>41.01572095202713}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Rsi.calculate(input_data, period: input_data.size+2, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
