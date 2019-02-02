require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "DC" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Donchian Channel' do
      it 'Calculates DC (20 day)' do
        output = TechnicalAnalysis::Dc.calculate(input_data, period: 20, price_key: :close)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>{:lower_bound=>142.19, :upper_bound=>170.95}},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>{:lower_bound=>142.19, :upper_bound=>170.95}},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>{:lower_bound=>142.19, :upper_bound=>170.95}},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>{:lower_bound=>142.19, :upper_bound=>174.72}},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>{:lower_bound=>142.19, :upper_bound=>176.69}},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>{:lower_bound=>146.83, :upper_bound=>184.82}},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>{:lower_bound=>150.73, :upper_bound=>184.82}},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>{:lower_bound=>156.83, :upper_bound=>184.82}},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>{:lower_bound=>160.89, :upper_bound=>184.82}},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>{:lower_bound=>163.94, :upper_bound=>185.86}},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>{:lower_bound=>163.94, :upper_bound=>193.53}},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>{:lower_bound=>165.48, :upper_bound=>193.53}},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>{:lower_bound=>168.49, :upper_bound=>193.53}},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>{:lower_bound=>168.49, :upper_bound=>193.53}},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>{:lower_bound=>168.49, :upper_bound=>194.17}},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>{:lower_bound=>168.49, :upper_bound=>204.47}},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>{:lower_bound=>168.49, :upper_bound=>208.49}},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>209.95}},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>209.95}},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>209.95}},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>209.95}},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>{:lower_bound=>172.29, :upper_bound=>222.22}},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>{:lower_bound=>176.78, :upper_bound=>222.22}},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>{:lower_bound=>176.98, :upper_bound=>222.22}},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>{:lower_bound=>185.86, :upper_bound=>222.73}},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>{:lower_bound=>186.8, :upper_bound=>222.73}},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>{:lower_bound=>186.8, :upper_bound=>222.73}},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>{:lower_bound=>186.8, :upper_bound=>222.73}},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>{:lower_bound=>192.23, :upper_bound=>222.73}},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>{:lower_bound=>194.17, :upper_bound=>222.73}},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>{:lower_bound=>201.59, :upper_bound=>222.73}},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>{:lower_bound=>201.59, :upper_bound=>222.73}},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>{:lower_bound=>201.59, :upper_bound=>222.73}},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>{:lower_bound=>201.59, :upper_bound=>222.73}},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>{:lower_bound=>201.59, :upper_bound=>226.87}}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Dc.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
