require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "Ichimoku" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)

    describe 'Ichimoku' do
      it 'Calculates Ichimoku' do
        output = TechnicalAnalysis::Ichimoku.calculate(input_data, low_period: 3, medium_period: 10, high_period: 20)

        expected_output = [
          {:date=>"2018/11/16", :value=> {:chikou_span=>201.59, :kijun_sen=>198.025, :senkou_span_a=>210.7325, :senkou_span_b=>212.72, :tenkan_sen=>190.44975}},
          {:date=>"2018/11/19", :value=> {:chikou_span=>203.77, :kijun_sen=>197.555, :senkou_span_a=>208.555, :senkou_span_b=>212.26, :tenkan_sen=>189.97975000000002}},
          {:date=>"2018/11/20", :value=> {:chikou_span=>209.95, :kijun_sen=>192.815, :senkou_span_a=>207.19, :senkou_span_b=>211.2, :tenkan_sen=>185.23975000000002}},
          {:date=>"2018/11/21", :value=> {:chikou_span=>208.49, :kijun_sen=>192.815, :senkou_span_a=>208.08499999999998, :senkou_span_b=>211.2, :tenkan_sen=>183.105}},
          {:date=>"2018/11/23", :value=> {:chikou_span=>204.47, :kijun_sen=>189.055, :senkou_span_a=>208.225, :senkou_span_b=>211.2, :tenkan_sen=>176.785}},
          {:date=>"2018/11/26", :value=> {:chikou_span=>194.17, :kijun_sen=>185.055, :senkou_span_a=>205.015, :senkou_span_b=>209.01, :tenkan_sen=>175.265}},
          {:date=>"2018/11/27", :value=> {:chikou_span=>192.23, :kijun_sen=>183.72, :senkou_span_a=>202.81755, :senkou_span_b=>207.84005, :tenkan_sen=>173.4275}},
          {:date=>"2018/11/28", :value=> {:chikou_span=>186.8, :kijun_sen=>182.61475000000002, :senkou_span_a=>198.51749999999998, :senkou_span_b=>205.07999999999998, :tenkan_sen=>175.77499999999998}},
          {:date=>"2018/11/29", :value=> {:chikou_span=>191.41, :kijun_sen=>182.61475000000002, :senkou_span_a=>195.6725, :senkou_span_b=>205.07999999999998, :tenkan_sen=>176.84}},
          {:date=>"2018/11/30", :value=> {:chikou_span=>193.53, :kijun_sen=>182.61475000000002, :senkou_span_a=>194.237375, :senkou_span_b=>205.07999999999998, :tenkan_sen=>178.865}},
          {:date=>"2018/12/03", :value=> {:chikou_span=>185.86, :kijun_sen=>180.48, :senkou_span_a=>193.76737500000002, :senkou_span_b=>204.61, :tenkan_sen=>180.985}},
          {:date=>"2018/12/04", :value=> {:chikou_span=>176.98, :kijun_sen=>177.6, :senkou_span_a=>189.027375, :senkou_span_b=>199.87, :tenkan_sen=>180.60500000000002}},
          {:date=>"2018/12/06", :value=> {:chikou_span=>176.78, :kijun_sen=>177.6, :senkou_span_a=>187.95999999999998, :senkou_span_b=>198.935, :tenkan_sen=>177.68}},
          {:date=>"2018/12/07", :value=> {:chikou_span=>172.29, :kijun_sen=>176.62, :senkou_span_a=>182.92000000000002, :senkou_span_b=>197.23000000000002, :tenkan_sen=>175.34495}},
          {:date=>"2018/12/10", :value=> {:chikou_span=>174.62, :kijun_sen=>174.135, :senkou_span_a=>180.16, :senkou_span_b=>196.31, :tenkan_sen=>169.055}},
          {:date=>"2018/12/11", :value=> {:chikou_span=>174.24, :kijun_sen=>174.135, :senkou_span_a=>178.57375000000002, :senkou_span_b=>196.31, :tenkan_sen=>168.91000000000003}},
          {:date=>"2018/12/12", :value=> {:chikou_span=>180.94, :kijun_sen=>174.135, :senkou_span_a=>179.194875, :senkou_span_b=>196.31, :tenkan_sen=>167.625}},
          {:date=>"2018/12/13", :value=> {:chikou_span=>179.55, :kijun_sen=>174.135, :senkou_span_a=>179.727375, :senkou_span_b=>196.31, :tenkan_sen=>169.785}},
          {:date=>"2018/12/14", :value=> {:chikou_span=>178.58, :kijun_sen=>174.135, :senkou_span_a=>180.739875, :senkou_span_b=>191.95499999999998, :tenkan_sen=>168.925}},
          {:date=>"2018/12/17", :value=> {:chikou_span=>184.82, :kijun_sen=>173.83499999999998, :senkou_span_a=>180.73250000000002, :senkou_span_b=>190.19, :tenkan_sen=>167.64999999999998}},
          {:date=>"2018/12/18", :value=> {:chikou_span=>176.69, :kijun_sen=>172.55995000000001, :senkou_span_a=>179.10250000000002, :senkou_span_b=>190.19, :tenkan_sen=>165.905}},
          {:date=>"2018/12/19", :value=> {:chikou_span=>174.72, :kijun_sen=>166.935, :senkou_span_a=>177.64, :senkou_span_b=>190.19, :tenkan_sen=>163.72}},
          {:date=>"2018/12/20", :value=> {:chikou_span=>168.49, :kijun_sen=>164.895, :senkou_span_a=>175.98247500000002, :senkou_span_b=>189.21, :tenkan_sen=>161.41500000000002}},
          {:date=>"2018/12/21", :value=> {:chikou_span=>169.6, :kijun_sen=>161.1, :senkou_span_a=>171.595, :senkou_span_b=>184.67000000000002, :tenkan_sen=>158.54}},
          {:date=>"2018/12/24", :value=> {:chikou_span=>168.63, :kijun_sen=>159.57999999999998, :senkou_span_a=>171.5225, :senkou_span_b=>181.59, :tenkan_sen=>154.35000000000002}},
          {:date=>"2018/12/26", :value=> {:chikou_span=>169.1, :kijun_sen=>159.57999999999998, :senkou_span_a=>170.88, :senkou_span_b=>180.255, :tenkan_sen=>152.375}},
          {:date=>"2018/12/27", :value=> {:chikou_span=>170.95, :kijun_sen=>159.57999999999998, :senkou_span_a=>171.95999999999998, :senkou_span_b=>179.14975, :tenkan_sen=>151.91}},
          {:date=>"2018/12/28", :value=> {:chikou_span=>165.48, :kijun_sen=>157.835, :senkou_span_a=>171.53, :senkou_span_b=>179.14975, :tenkan_sen=>152.62}},
          {:date=>"2018/12/31", :value=> {:chikou_span=>163.94, :kijun_sen=>157.47, :senkou_span_a=>170.74249999999998, :senkou_span_b=>178.84975, :tenkan_sen=>154.715}},
          {:date=>"2019/01/02", :value=> {:chikou_span=>166.07, :kijun_sen=>157.06, :senkou_span_a=>169.23247500000002, :senkou_span_b=>176.71499999999997, :tenkan_sen=>156.79500000000002}},
          {:date=>"2019/01/03", :value=> {:chikou_span=>160.89, :kijun_sen=>154.725, :senkou_span_a=>165.3275, :senkou_span_b=>172.015, :tenkan_sen=>150.68}},
          {:date=>"2019/01/04", :value=> {:chikou_span=>156.83, :kijun_sen=>152.055, :senkou_span_a=>163.15500000000003, :senkou_span_b=>170.12, :tenkan_sen=>150.425}},
          {:date=>"2019/01/07", :value=> {:chikou_span=>150.73, :kijun_sen=>150.68, :senkou_span_a=>159.82, :senkou_span_b=>167.285, :tenkan_sen=>145.41500000000002}},
          {:date=>"2019/01/08", :value=> {:chikou_span=>146.83, :kijun_sen=>150.68, :senkou_span_a=>156.965, :senkou_span_b=>165.765, :tenkan_sen=>147.81}},
          {:date=>"2019/01/09", :value=> {:chikou_span=>157.17, :kijun_sen=>150.68, :senkou_span_a=>155.9775, :senkou_span_b=>165.765, :tenkan_sen=>150.215}}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        medium_period = 20
        high_period = 40
        size_limit = (medium_period + high_period + 1)
        
        expect {TechnicalAnalysis::Ichimoku.calculate(input_data, high_period: size_limit)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
