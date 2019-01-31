require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "MACD" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Moving Average Convergence Divergence' do
      it 'Calculates MACD (12, 26, 9)' do
        output = TechnicalAnalysis::Macd.calculate(input_data, fast_period: 12, slow_period: 26, signal_period: 9, price_key: :close)

        expected_output = [
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=> {:macd_histogram=>-2.0270413850598707, :macd_line=>-12.190566653015793, :signal_line=>-10.163525267955922}},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=> {:macd_histogram=>-1.6877775772534704, :macd_line=>-12.27324723952276, :signal_line=>-10.58546966226929}},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=> {:macd_histogram=>-0.8625734517317483, :macd_line=>-11.663686476933975, :signal_line=>-10.801113025202227}},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=> {:macd_histogram=>-0.29036883404714864, :macd_line=>-11.164074067761163, :signal_line=>-10.873705233714015}},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=> {:macd_histogram=>0.12072991006954936, :macd_line=>-10.722792846127078, :signal_line=>-10.843522756196627}},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=> {:macd_histogram=>0.8691503265374259, :macd_line=>-9.757084848024846, :signal_line=>-10.626235174562272}},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=> {:macd_histogram=>0.8707231988258766, :macd_line=>-9.537831176029925, :signal_line=>-10.408554374855802}},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=> {:macd_histogram=>0.7952363015170398, :macd_line=>-9.414508997959501, :signal_line=>-10.209745299476541}},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=> {:macd_histogram=>0.40173122915939885, :macd_line=>-9.707581263027294, :signal_line=>-10.109312492186692}},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=> {:macd_histogram=>0.29703273753484893, :macd_line=>-9.738021570268131, :signal_line=>-10.03505430780298}},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=> {:macd_histogram=>0.24542334510443808, :macd_line=>-9.728275126422432, :signal_line=>-9.97369847152687}},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=> {:macd_histogram=>0.3211326876237397, :macd_line=>-9.572282611997196, :signal_line=>-9.893415299620935}},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=> {:macd_histogram=>0.5600105875119272, :macd_line=>-9.193402065231027, :signal_line=>-9.753412652742954}},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=> {:macd_histogram=>0.420215327266785, :macd_line=>-9.228143493659474, :signal_line=>-9.648358820926259}},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=> {:macd_histogram=>0.30024902798283826, :macd_line=>-9.273047535947711, :signal_line=>-9.57329656393055}},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=> {:macd_histogram=>0.4325264668638127, :macd_line=>-9.032638480350784, :signal_line=>-9.465164947214596}},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=> {:macd_histogram=>0.24847825431282367, :macd_line=>-9.154567129323567, :signal_line=>-9.40304538363639}},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=> {:macd_histogram=>-0.053279185610067614, :macd_line=>-9.469644365648975, :signal_line=>-9.416365180038907}},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=> {:macd_histogram=>-0.5430624653584708, :macd_line=>-10.095193261736995, :signal_line=>-9.552130796378524}},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=> {:macd_histogram=>-0.9833848403830618, :macd_line=>-10.78136184685735, :signal_line=>-9.797977006474289}},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=> {:macd_histogram=>-0.45861878631368036, :macd_line=>-10.371250489366389, :signal_line=>-9.912631703052709}},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=> {:macd_histogram=>-0.0803864814327433, :macd_line=>-10.013114804843639, :signal_line=>-9.932728323410895}},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=> {:macd_histogram=>0.25655639311731626, :macd_line=>-9.61203283201425, :signal_line=>-9.868589225131567}},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=> {:macd_histogram=>0.6406312657329245, :macd_line=>-9.06780014296541, :signal_line=>-9.708431408698335}},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=> {:macd_histogram=>0.9477761010428516, :macd_line=>-8.523711282394771, :signal_line=>-9.471487383437623}},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=> {:macd_histogram=>0.17310243476363496, :macd_line=>-9.255109339983079, :signal_line=>-9.428211774746714}},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=> {:macd_histogram=>0.15180609943062073, :macd_line=>-9.238454150458438, :signal_line=>-9.390260249889058}},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=> {:macd_histogram=>0.19504942363819744, :macd_line=>-9.146448470341312, :signal_line=>-9.34149789397951}},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=> {:macd_histogram=>0.4770591535283888, :macd_line=>-8.745173952069024, :signal_line=>-9.222233105597413}},
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=> {:macd_histogram=>0.8762597178840466, :macd_line=>-8.126908458242355, :signal_line=>-9.003168176126401}}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Macd.calculate(input_data, slow_period: input_data.size+1, signal_period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
