require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "SMA" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Simple Moving Average' do
      it 'Calculates SMA (5 day)' do
        output = TechnicalAnalysis::Sma.calculate(input_data, period: 5, price_key: :close)

        expected_output = [
          {:date_time=>"2018-10-15T00:00:00.000Z", :value=>219.43},
          {:date_time=>"2018-10-16T00:00:00.000Z", :value=>218.48600000000002},
          {:date_time=>"2018-10-17T00:00:00.000Z", :value=>219.452},
          {:date_time=>"2018-10-18T00:00:00.000Z", :value=>219.766},
          {:date_time=>"2018-10-19T00:00:00.000Z", :value=>219.206},
          {:date_time=>"2018-10-22T00:00:00.000Z", :value=>219.86400000000003},
          {:date_time=>"2018-10-23T00:00:00.000Z", :value=>219.97999999999996},
          {:date_time=>"2018-10-24T00:00:00.000Z", :value=>218.76},
          {:date_time=>"2018-10-25T00:00:00.000Z", :value=>219.51600000000002},
          {:date_time=>"2018-10-26T00:00:00.000Z", :value=>218.914},
          {:date_time=>"2018-10-29T00:00:00.000Z", :value=>217.23200000000003},
          {:date_time=>"2018-10-30T00:00:00.000Z", :value=>215.346},
          {:date_time=>"2018-10-31T00:00:00.000Z", :value=>216.1},
          {:date_time=>"2018-11-01T00:00:00.000Z", :value=>216.584},
          {:date_time=>"2018-11-02T00:00:00.000Z", :value=>214.82000000000002},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>212.69},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>210.78400000000002},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>209.002},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>206.256},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>205.654},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>204.17000000000002},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>201.862},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>197.23200000000003},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>193.816},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>191.628},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>189.96599999999998},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>186.916},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>184.91199999999998},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>181.088},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>177.30599999999998},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>174.982},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>175.77400000000003},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>176.32799999999997},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>177.58599999999998},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>179.62600000000003},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>180.11600000000004},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>178.872},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>176.66},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>174.864},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>171.626},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>170.108},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>169.35399999999998},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>168.752},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>167.61999999999998},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>167.108},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>165.46599999999998},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>162.642},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>159.692},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>156.27},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>154.49},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>153.54199999999997},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>153.422},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>154.824},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>157.04199999999997},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>154.046},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>152.468},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>150.808},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>149.41},
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>148.488}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Sma.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
