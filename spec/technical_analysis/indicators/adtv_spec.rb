require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "ADTV" do
    input_data = SpecHelper.get_test_data(:volume)

    describe 'Average Daily Trading Volume' do
      it 'Calculates ADTV (22 day)' do
        output = TechnicalAnalysis::Adtv.calculate(input_data, period: 22, price_key: :volume)

        expected_output = [
          {:date=>"2018/11/07", :value=>40280851.81818182},
          {:date=>"2018/11/08", :value=>40218699.09090909},
          {:date=>"2018/11/09", :value=>39911139.54545455},
          {:date=>"2018/11/12", :value=>39824262.72727273},
          {:date=>"2018/11/13", :value=>40152941.81818182},
          {:date=>"2018/11/14", :value=>41528709.54545455},
          {:date=>"2018/11/15", :value=>42322760.0},
          {:date=>"2018/11/16", :value=>42936325.90909091},
          {:date=>"2018/11/19", :value=>43356214.09090909},
          {:date=>"2018/11/20", :value=>44938230.0},
          {:date=>"2018/11/21", :value=>45044807.27272727},
          {:date=>"2018/11/23", :value=>44360389.09090909},
          {:date=>"2018/11/26", :value=>44572670.90909091},
          {:date=>"2018/11/27", :value=>45123980.0},
          {:date=>"2018/11/28", :value=>45067164.09090909},
          {:date=>"2018/11/29", :value=>44876704.54545455},
          {:date=>"2018/11/30", :value=>45010174.09090909},
          {:date=>"2018/12/03", :value=>45124760.0},
          {:date=>"2018/12/04", :value=>44587813.63636363},
          {:date=>"2018/12/06", :value=>42390465.90909091},
          {:date=>"2018/12/07", :value=>41281670.90909091},
          {:date=>"2018/12/10", :value=>42644592.72727273},
          {:date=>"2018/12/11", :value=>43220792.72727273},
          {:date=>"2018/12/12", :value=>43683765.90909091},
          {:date=>"2018/12/13", :value=>43567240.90909091},
          {:date=>"2018/12/14", :value=>43095846.81818182},
          {:date=>"2018/12/17", :value=>42937879.09090909},
          {:date=>"2018/12/18", :value=>41719976.81818182},
          {:date=>"2018/12/19", :value=>41780250.0},
          {:date=>"2018/12/20", :value=>43062381.81818182},
          {:date=>"2018/12/21", :value=>45511067.27272727},
          {:date=>"2018/12/24", :value=>44124274.09090909},
          {:date=>"2018/12/26", :value=>45353256.36363637},
          {:date=>"2018/12/27", :value=>46625296.36363637},
          {:date=>"2018/12/28", :value=>46492490.90909091},
          {:date=>"2018/12/31", :value=>46189911.36363637},
          {:date=>"2019/01/02", :value=>45721516.81818182},
          {:date=>"2019/01/03", :value=>47975301.36363637},
          {:date=>"2019/01/04", :value=>48793455.45454545},
          {:date=>"2019/01/07", :value=>49431352.72727273},
          {:date=>"2019/01/08", :value=>49407791.81818182},
          {:date=>"2019/01/09", :value=>49513676.36363637}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Adtv.calculate(input_data, period: input_data.size+1, price_key: :volume)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
