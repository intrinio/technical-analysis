require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "UO" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)

    describe 'Ultimate Oscillator' do
      it 'Calculates UO (5 day)' do
        output = TechnicalAnalysis::Uo.calculate(input_data, short_period: 7, medium_period: 14, long_period: 28, short_weight: 4, medium_weight: 2, long_weight: 1)

        expected_output = [
          {:date=>"2018/11/16", :value=>37.48593642184523},
          {:date=>"2018/11/19", :value=>33.50557345611348},
          {:date=>"2018/11/20", :value=>29.938582222468735},
          {:date=>"2018/11/21", :value=>30.12209085444982},
          {:date=>"2018/11/23", :value=>30.31628731487427},
          {:date=>"2018/11/26", :value=>37.129780535443615},
          {:date=>"2018/11/27", :value=>36.448196445521205},
          {:date=>"2018/11/28", :value=>39.6100967511459},
          {:date=>"2018/11/29", :value=>42.75825214517756},
          {:date=>"2018/11/30", :value=>48.76091038333585},
          {:date=>"2018/12/03", :value=>58.63742128493122},
          {:date=>"2018/12/04", :value=>54.53131218526129},
          {:date=>"2018/12/06", :value=>54.531561679403225},
          {:date=>"2018/12/07", :value=>46.3795568325064},
          {:date=>"2018/12/10", :value=>46.78620949538559},
          {:date=>"2018/12/11", :value=>47.39018769748099},
          {:date=>"2018/12/12", :value=>46.56343334880161},
          {:date=>"2018/12/13", :value=>42.5926187322538},
          {:date=>"2018/12/14", :value=>43.99139965247388},
          {:date=>"2018/12/17", :value=>38.091246151228205},
          {:date=>"2018/12/18", :value=>42.6017793901735},
          {:date=>"2018/12/19", :value=>31.693410049073588},
          {:date=>"2018/12/20", :value=>30.219780692869403},
          {:date=>"2018/12/21", :value=>28.31825074884628},
          {:date=>"2018/12/24", :value=>24.01487703769969},
          {:date=>"2018/12/26", :value=>38.89197235556109},
          {:date=>"2018/12/27", :value=>44.80062908207362},
          {:date=>"2018/12/28", :value=>44.736408028234784},
          {:date=>"2018/12/31", :value=>46.12625788315007},
          {:date=>"2019/01/02", :value=>51.63477005783912},
          {:date=>"2019/01/03", :value=>43.660461129633255},
          {:date=>"2019/01/04", :value=>50.726610056055335},
          {:date=>"2019/01/07", :value=>46.58165158841807},
          {:date=>"2019/01/08", :value=>44.828908983561035},
          {:date=>"2019/01/09", :value=>47.28872762629681}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Uo.calculate(input_data, long_period: input_data.size+2)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
