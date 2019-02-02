require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "CMF" do
    input_data = SpecHelper.get_test_data(:high, :low, :close, :volume)

    describe 'Chaikin Money Flow' do
      it 'Calculates CMF (20 day)' do
        output = TechnicalAnalysis::Cmf.calculate(input_data, period: 20)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>-0.14148236474171028},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>-0.10900349402409147},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>-0.16209459049078995},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>-0.14338098793972473},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>-0.23384083275693518},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>-0.1171779554311941},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>-0.1421967277504723},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>-0.14870217725852253},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>-0.09771633750350824},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>-0.11185040161958644},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>-0.13433878933016613},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>-0.12311876857928804},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>-0.08053545285645361},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>-0.07883316711924936},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>-0.08160027269601758},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>-0.0635610565928198},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>0.008829457014340984},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>-0.005177700749048257},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>-0.041279122544240626},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>-0.05299093511730075},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>-0.02994416009907359},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>-0.09289096149170357},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>-0.008556645577315109},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>-0.044697234566322144},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>0.006195178249247199},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>-0.08707816577338795},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>-0.02808273355873217},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>-0.008559410227273146},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>-0.039334642581608396},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>-0.07707518115228632},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>-0.12097582444999905},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>-0.0864519745264971},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>-0.09451983283878523},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>-0.02107439975862456},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>0.004132959703610273},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>-0.016262278292090777},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>-0.06224056395025631},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>-0.00325588286845078},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>0.06492697386482489},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>0.08638139363431603},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>0.11517576782439708},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>0.0839939173853672},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>-0.002328367522189358},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>0.010519910116535688}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Cmf.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
