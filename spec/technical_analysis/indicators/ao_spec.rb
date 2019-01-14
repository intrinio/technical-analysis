require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "AO" do
    input_data = SpecHelper.get_test_data(:high, :low)

    describe 'Awesome Oscillator' do
      it 'Calculates AO (5 day short period, 34 day long period)' do
        output = TechnicalAnalysis::Ao.calculate(input_data, short_period: 5, long_period: 34)

        expected_output = [
          {:date=>"2018/11/26", :value=>-28.26261029411762},
          {:date=>"2018/11/27", :value=>-29.739166176470576},
          {:date=>"2018/11/28", :value=>-28.547813235294086},
          {:date=>"2018/11/29", :value=>-27.130989705882314},
          {:date=>"2018/11/30", :value=>-25.05331323529407},
          {:date=>"2018/12/03", :value=>-21.886519117646998},
          {:date=>"2018/12/04", :value=>-19.392987941176415},
          {:date=>"2018/12/06", :value=>-19.071752647058815},
          {:date=>"2018/12/07", :value=>-19.51995852941178},
          {:date=>"2018/12/10", :value=>-20.365870294117656},
          {:date=>"2018/12/11", :value=>-21.579664411764696},
          {:date=>"2018/12/12", :value=>-21.92503676470585},
          {:date=>"2018/12/13", :value=>-20.811713235294178},
          {:date=>"2018/12/14", :value=>-20.12868382352943},
          {:date=>"2018/12/17", :value=>-18.865919117647138},
          {:date=>"2018/12/18", :value=>-18.17262500000004},
          {:date=>"2018/12/19", :value=>-18.17277205882357},
          {:date=>"2018/12/20", :value=>-18.88406617647061},
          {:date=>"2018/12/21", :value=>-19.609007352941205},
          {:date=>"2018/12/24", :value=>-21.124477941176536},
          {:date=>"2018/12/26", :value=>-22.471330882352987},
          {:date=>"2018/12/27", :value=>-22.97706617647063},
          {:date=>"2018/12/28", :value=>-21.924007352941203},
          {:date=>"2018/12/31", :value=>-19.633272058823536},
          {:date=>"2019/01/02", :value=>-16.73956617647059},
          {:date=>"2019/01/03", :value=>-16.804919117647017},
          {:date=>"2019/01/04", :value=>-16.838043823529347},
          {:date=>"2019/01/07", :value=>-17.41204382352936},
          {:date=>"2019/01/08", :value=>-17.8071908823529},
          {:date=>"2019/01/09", :value=>-17.518757058823525},
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Ao.calculate(input_data, long_period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
