require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "AO" do
    input_data = SpecHelper.get_test_data(:high, :low)

    describe 'Awesome Oscillator' do
      it 'Calculates AO (5 day short period, 34 day long period)' do
        output = TechnicalAnalysis::Ao.calculate(input_data, short_period: 5, long_period: 34)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>-17.518757058823525},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>-17.8071908823529},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>-17.41204382352936},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>-16.838043823529347},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>-16.804919117647017},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>-16.73956617647059},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>-19.633272058823536},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>-21.924007352941203},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>-22.97706617647063},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>-22.471330882352987},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>-21.124477941176536},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>-19.609007352941205},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>-18.88406617647061},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>-18.17277205882357},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>-18.17262500000004},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>-18.865919117647138},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>-20.12868382352943},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>-20.811713235294178},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>-21.92503676470585},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>-21.579664411764696},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>-20.365870294117656},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>-19.51995852941178},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>-19.071752647058815},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>-19.392987941176415},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>-21.886519117646998},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>-25.05331323529407},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>-27.130989705882314},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>-28.547813235294086},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>-29.739166176470576},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>-28.26261029411762}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Ao.calculate(input_data, long_period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
