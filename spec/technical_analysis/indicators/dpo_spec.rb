require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "DPO" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Detrended Price Oscillator' do
      it 'Calculates DPO (20 day)' do
        output = TechnicalAnalysis::Dpo.calculate(input_data, period: 20, price_key: :close)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>-15.774999999999977},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>-19.607999999999976},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>-23.730500000000006},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>-24.407999999999987},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>-31.726499999999987},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>-17.36949999999996},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>-18.922999999999973},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>-21.498999999999995},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>-22.642999999999972},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>-22.876499999999993},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>-35.0085},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>-33.053},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>-29.025999999999982},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>-26.41850000000005},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>-22.48350000000005},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>-25.746500000000054},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>-26.388500000000022},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>-22.884000000000043},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>-26.35200000000006},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>-28.722000000000037},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>-29.836000000000013},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>-33.321500000000015},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>-29.007000000000033},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>-29.3245},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>-22.93399999999997},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>-30.462999999999965},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>-30.723499999999945},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>-31.052999999999997},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>-39.24899999999997},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>-40.02850000000001},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>-43.2405},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>-39.04850000000002},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>-39.16900000000004},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>-31.444000000000017}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Dpo.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
