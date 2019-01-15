require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "OBV Mean" do
    input_data = SpecHelper.get_test_data(:close, :volume)

    describe 'On-balance Volume Mean' do
      it 'Calculates OBV Mean (10 day)' do
        output = TechnicalAnalysis::ObvMean.calculate(input_data, period: 10)

        expected_output = [
          {:date=>"2018/10/23", :value=>-65836555.0},
          {:date=>"2018/10/24", :value=>-66801824.0},
          {:date=>"2018/10/25", :value=>-59574127.0},
          {:date=>"2018/10/26", :value=>-61015077.0},
          {:date=>"2018/10/29", :value=>-63999351.0},
          {:date=>"2018/10/30", :value=>-66215087.0},
          {:date=>"2018/10/31", :value=>-62359854.0},
          {:date=>"2018/11/01", :value=>-49970286.0},
          {:date=>"2018/11/02", :value=>-49972807.0},
          {:date=>"2018/11/05", :value=>-59457699.0},
          {:date=>"2018/11/06", :value=>-69633236.0},
          {:date=>"2018/11/07", :value=>-72480397.0},
          {:date=>"2018/11/08", :value=>-80759219.0},
          {:date=>"2018/11/09", :value=>-87750647.0},
          {:date=>"2018/11/12", :value=>-95269809.0},
          {:date=>"2018/11/13", :value=>-111110335.0},
          {:date=>"2018/11/14", :value=>-136807276.0},
          {:date=>"2018/11/15", :value=>-163172458.0},
          {:date=>"2018/11/16", :value=>-176813851.0},
          {:date=>"2018/11/19", :value=>-188010709.0},
          {:date=>"2018/11/20", :value=>-209152907.0},
          {:date=>"2018/11/21", :value=>-236733893.0},
          {:date=>"2018/11/23", :value=>-264148349.0},
          {:date=>"2018/11/26", :value=>-283664797.0},
          {:date=>"2018/11/27", :value=>-302197756.0},
          {:date=>"2018/11/28", :value=>-311463969.0},
          {:date=>"2018/11/29", :value=>-318827806.0},
          {:date=>"2018/11/30", :value=>-334761235.0},
          {:date=>"2018/12/03", :value=>-350260027.0},
          {:date=>"2018/12/04", :value=>-365710262.0},
          {:date=>"2018/12/06", :value=>-378663120.0},
          {:date=>"2018/12/07", :value=>-392674222.0},
          {:date=>"2018/12/10", :value=>-398147027.0},
          {:date=>"2018/12/11", :value=>-412682868.0},
          {:date=>"2018/12/12", :value=>-419555627.0},
          {:date=>"2018/12/13", :value=>-427847140.0},
          {:date=>"2018/12/14", :value=>-436048331.0},
          {:date=>"2018/12/17", :value=>-444632138.0},
          {:date=>"2018/12/18", :value=>-453894366.0},
          {:date=>"2018/12/19", :value=>-463802236.0},
          {:date=>"2018/12/20", :value=>-475879438.0},
          {:date=>"2018/12/21", :value=>-493338562.0},
          {:date=>"2018/12/24", :value=>-520690509.0},
          {:date=>"2018/12/26", :value=>-537632267.0},
          {:date=>"2018/12/27", :value=>-563282378.0},
          {:date=>"2018/12/28", :value=>-587933850.0},
          {:date=>"2018/12/31", :value=>-605073347.0},
          {:date=>"2019/01/02", :value=>-614324095.0},
          {:date=>"2019/01/03", :value=>-636060876.0},
          {:date=>"2019/01/04", :value=>-647295525.0},
          {:date=>"2019/01/07", :value=>-657547495.0},
          {:date=>"2019/01/08", :value=>-654187384.0},
          {:date=>"2019/01/09", :value=>-642606913.0}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::ObvMean.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
