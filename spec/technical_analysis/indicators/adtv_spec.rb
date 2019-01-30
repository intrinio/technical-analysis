require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "ADTV" do
    input_data = SpecHelper.get_test_data(:volume)

    describe 'Average Daily Trading Volume' do
      it 'Calculates ADTV (22 day)' do
        output = TechnicalAnalysis::Adtv.calculate(input_data, period: 22, volume_key: :volume)

        expected_output = [
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>40280851.81818182},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>40218699.09090909},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>39911139.54545455},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>39824262.72727273},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>40152941.81818182},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>41528709.54545455},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>42322760.0},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>42936325.90909091},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>43356214.09090909},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>44938230.0},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>45044807.27272727},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>44360389.09090909},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>44572670.90909091},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>45123980.0},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>45067164.09090909},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>44876704.54545455},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>45010174.09090909},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>45124760.0},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>44587813.63636363},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>42390465.90909091},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>41281670.90909091},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>42644592.72727273},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>43220792.72727273},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>43683765.90909091},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>43567240.90909091},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>43095846.81818182},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>42937879.09090909},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>41719976.81818182},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>41780250.0},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>43062381.81818182},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>45511067.27272727},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>44124274.09090909},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>45353256.36363637},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>46625296.36363637},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>46492490.90909091},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>46189911.36363637},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>45721516.81818182},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>47975301.36363637},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>48793455.45454545},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>49431352.72727273},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>49407791.81818182},
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>49513676.36363637}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Adtv.calculate(input_data, period: input_data.size+1, volume_key: :volume)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
