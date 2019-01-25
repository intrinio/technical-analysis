require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "DC" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Donchian Channel' do
      it 'Calculates DC (20 day)' do
        output = TechnicalAnalysis::Dc.calculate(input_data, period: 20, price_key: :close)

        expected_output = [
          {:date=>"2018/11/05", :value=>{:lower_bound=>201.59, :upper_bound=>226.87}},
          {:date=>"2018/11/06", :value=>{:lower_bound=>201.59, :upper_bound=>222.73}},
          {:date=>"2018/11/07", :value=>{:lower_bound=>201.59, :upper_bound=>222.73}},
          {:date=>"2018/11/08", :value=>{:lower_bound=>201.59, :upper_bound=>222.73}},
          {:date=>"2018/11/09", :value=>{:lower_bound=>201.59, :upper_bound=>222.73}},
          {:date=>"2018/11/12", :value=>{:lower_bound=>194.17, :upper_bound=>222.73}},
          {:date=>"2018/11/13", :value=>{:lower_bound=>192.23, :upper_bound=>222.73}},
          {:date=>"2018/11/14", :value=>{:lower_bound=>186.8, :upper_bound=>222.73}},
          {:date=>"2018/11/15", :value=>{:lower_bound=>186.8, :upper_bound=>222.73}},
          {:date=>"2018/11/16", :value=>{:lower_bound=>186.8, :upper_bound=>222.73}},
          {:date=>"2018/11/19", :value=>{:lower_bound=>185.86, :upper_bound=>222.73}},
          {:date=>"2018/11/20", :value=>{:lower_bound=>176.98, :upper_bound=>222.22}},
          {:date=>"2018/11/21", :value=>{:lower_bound=>176.78, :upper_bound=>222.22}},
          {:date=>"2018/11/23", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date=>"2018/11/26", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date=>"2018/11/27", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date=>"2018/11/28", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date=>"2018/11/29", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date=>"2018/11/30", :value=>{:lower_bound=>172.29, :upper_bound=>209.95}},
          {:date=>"2018/12/03", :value=>{:lower_bound=>172.29, :upper_bound=>209.95}},
          {:date=>"2018/12/04", :value=>{:lower_bound=>172.29, :upper_bound=>209.95}},
          {:date=>"2018/12/06", :value=>{:lower_bound=>172.29, :upper_bound=>209.95}},
          {:date=>"2018/12/07", :value=>{:lower_bound=>168.49, :upper_bound=>208.49}},
          {:date=>"2018/12/10", :value=>{:lower_bound=>168.49, :upper_bound=>204.47}},
          {:date=>"2018/12/11", :value=>{:lower_bound=>168.49, :upper_bound=>194.17}},
          {:date=>"2018/12/12", :value=>{:lower_bound=>168.49, :upper_bound=>193.53}},
          {:date=>"2018/12/13", :value=>{:lower_bound=>168.49, :upper_bound=>193.53}},
          {:date=>"2018/12/14", :value=>{:lower_bound=>165.48, :upper_bound=>193.53}},
          {:date=>"2018/12/17", :value=>{:lower_bound=>163.94, :upper_bound=>193.53}},
          {:date=>"2018/12/18", :value=>{:lower_bound=>163.94, :upper_bound=>185.86}},
          {:date=>"2018/12/19", :value=>{:lower_bound=>160.89, :upper_bound=>184.82}},
          {:date=>"2018/12/20", :value=>{:lower_bound=>156.83, :upper_bound=>184.82}},
          {:date=>"2018/12/21", :value=>{:lower_bound=>150.73, :upper_bound=>184.82}},
          {:date=>"2018/12/24", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date=>"2018/12/26", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date=>"2018/12/27", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date=>"2018/12/28", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date=>"2018/12/31", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date=>"2019/01/02", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date=>"2019/01/03", :value=>{:lower_bound=>142.19, :upper_bound=>176.69}},
          {:date=>"2019/01/04", :value=>{:lower_bound=>142.19, :upper_bound=>174.72}},
          {:date=>"2019/01/07", :value=>{:lower_bound=>142.19, :upper_bound=>170.95}},
          {:date=>"2019/01/08", :value=>{:lower_bound=>142.19, :upper_bound=>170.95}},
          {:date=>"2019/01/09", :value=>{:lower_bound=>142.19, :upper_bound=>170.95}}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Dc.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
