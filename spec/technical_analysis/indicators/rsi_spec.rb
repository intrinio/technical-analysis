require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "RSI" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Relative Strength Index' do
      it 'Calculates RSI (14 day)' do
        output = TechnicalAnalysis::Rsi.calculate(input_data, period: 14, price_key: :close)

        expected_output = [
          {:date=>"2018/10/29", :value=>38.27160493827161},
          {:date=>"2018/10/30", :value=>39.38109368376431},
          {:date=>"2018/10/31", :value=>44.96841382331871},
          {:date=>"2018/11/01", :value=>48.08268788472883},
          {:date=>"2018/11/02", :value=>37.93941116682432},
          {:date=>"2018/11/05", :value=>34.78189708111985},
          {:date=>"2018/11/06", :value=>36.875893042068746},
          {:date=>"2018/11/07", :value=>42.51108193242363},
          {:date=>"2018/11/08", :value=>41.56699725744853},
          {:date=>"2018/11/09", :value=>38.99885805229995},
          {:date=>"2018/11/12", :value=>33.31877385045367},
          {:date=>"2018/11/13", :value=>32.36268849740294},
          {:date=>"2018/11/14", :value=>29.78632377839773},
          {:date=>"2018/11/15", :value=>34.550163030510646},
          {:date=>"2018/11/16", :value=>36.677863857193564},
          {:date=>"2018/11/19", :value=>32.554453236286506},
          {:date=>"2018/11/20", :value=>28.552282046348225},
          {:date=>"2018/11/21", :value=>28.467396310763007},
          {:date=>"2018/11/23", :value=>26.558433878585916},
          {:date=>"2018/11/26", :value=>29.211255846774762},
          {:date=>"2018/11/27", :value=>29.027101402280678},
          {:date=>"2018/11/28", :value=>36.61457624117541},
          {:date=>"2018/11/29", :value=>35.760430191057694},
          {:date=>"2018/11/30", :value=>35.1442970032345},
          {:date=>"2018/12/03", :value=>42.06016450933706},
          {:date=>"2018/12/04", :value=>36.58615110748291},
          {:date=>"2018/12/06", :value=>35.38441991619841},
          {:date=>"2018/12/07", :value=>31.82436379692355},
          {:date=>"2018/12/10", :value=>33.115551932880564},
          {:date=>"2018/12/11", :value=>32.53565170863392},
          {:date=>"2018/12/12", :value=>33.146531878947414},
          {:date=>"2018/12/13", :value=>35.61772436774288},
          {:date=>"2018/12/14", :value=>31.866930881658718},
          {:date=>"2018/12/17", :value=>30.880956115136144},
          {:date=>"2018/12/18", :value=>33.926041361905774},
          {:date=>"2018/12/19", :value=>30.416532991054595},
          {:date=>"2018/12/20", :value=>27.973957664061984},
          {:date=>"2018/12/21", :value=>24.757134961511937},
          {:date=>"2018/12/24", :value=>22.94077952430888},
          {:date=>"2018/12/26", :value=>36.28727515078207},
          {:date=>"2018/12/27", :value=>35.63166885267985},
          {:date=>"2018/12/28", :value=>35.7297472286003},
          {:date=>"2018/12/31", :value=>37.66054013673465},
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
