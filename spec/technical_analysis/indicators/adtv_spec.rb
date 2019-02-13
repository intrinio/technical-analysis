require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "ADTV" do
    input_data = SpecHelper.get_test_data(:volume)
    indicator = TechnicalAnalysis::Adtv

    describe 'Average Daily Trading Volume' do
      it 'Calculates ADTV (22 day)' do
        output = indicator.calculate(input_data, period: 22, volume_key: :volume)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :adtv=>49513676.36363637},
          {:date_time=>"2019-01-08T00:00:00.000Z", :adtv=>49407791.81818182},
          {:date_time=>"2019-01-07T00:00:00.000Z", :adtv=>49431352.72727273},
          {:date_time=>"2019-01-04T00:00:00.000Z", :adtv=>48793455.45454545},
          {:date_time=>"2019-01-03T00:00:00.000Z", :adtv=>47975301.36363637},
          {:date_time=>"2019-01-02T00:00:00.000Z", :adtv=>45721516.81818182},
          {:date_time=>"2018-12-31T00:00:00.000Z", :adtv=>46189911.36363637},
          {:date_time=>"2018-12-28T00:00:00.000Z", :adtv=>46492490.90909091},
          {:date_time=>"2018-12-27T00:00:00.000Z", :adtv=>46625296.36363637},
          {:date_time=>"2018-12-26T00:00:00.000Z", :adtv=>45353256.36363637},
          {:date_time=>"2018-12-24T00:00:00.000Z", :adtv=>44124274.09090909},
          {:date_time=>"2018-12-21T00:00:00.000Z", :adtv=>45511067.27272727},
          {:date_time=>"2018-12-20T00:00:00.000Z", :adtv=>43062381.81818182},
          {:date_time=>"2018-12-19T00:00:00.000Z", :adtv=>41780250.0},
          {:date_time=>"2018-12-18T00:00:00.000Z", :adtv=>41719976.81818182},
          {:date_time=>"2018-12-17T00:00:00.000Z", :adtv=>42937879.09090909},
          {:date_time=>"2018-12-14T00:00:00.000Z", :adtv=>43095846.81818182},
          {:date_time=>"2018-12-13T00:00:00.000Z", :adtv=>43567240.90909091},
          {:date_time=>"2018-12-12T00:00:00.000Z", :adtv=>43683765.90909091},
          {:date_time=>"2018-12-11T00:00:00.000Z", :adtv=>43220792.72727273},
          {:date_time=>"2018-12-10T00:00:00.000Z", :adtv=>42644592.72727273},
          {:date_time=>"2018-12-07T00:00:00.000Z", :adtv=>41281670.90909091},
          {:date_time=>"2018-12-06T00:00:00.000Z", :adtv=>42390465.90909091},
          {:date_time=>"2018-12-04T00:00:00.000Z", :adtv=>44587813.63636363},
          {:date_time=>"2018-12-03T00:00:00.000Z", :adtv=>45124760.0},
          {:date_time=>"2018-11-30T00:00:00.000Z", :adtv=>45010174.09090909},
          {:date_time=>"2018-11-29T00:00:00.000Z", :adtv=>44876704.54545455},
          {:date_time=>"2018-11-28T00:00:00.000Z", :adtv=>45067164.09090909},
          {:date_time=>"2018-11-27T00:00:00.000Z", :adtv=>45123980.0},
          {:date_time=>"2018-11-26T00:00:00.000Z", :adtv=>44572670.90909091},
          {:date_time=>"2018-11-23T00:00:00.000Z", :adtv=>44360389.09090909},
          {:date_time=>"2018-11-21T00:00:00.000Z", :adtv=>45044807.27272727},
          {:date_time=>"2018-11-20T00:00:00.000Z", :adtv=>44938230.0},
          {:date_time=>"2018-11-19T00:00:00.000Z", :adtv=>43356214.09090909},
          {:date_time=>"2018-11-16T00:00:00.000Z", :adtv=>42936325.90909091},
          {:date_time=>"2018-11-15T00:00:00.000Z", :adtv=>42322760.0},
          {:date_time=>"2018-11-14T00:00:00.000Z", :adtv=>41528709.54545455},
          {:date_time=>"2018-11-13T00:00:00.000Z", :adtv=>40152941.81818182},
          {:date_time=>"2018-11-12T00:00:00.000Z", :adtv=>39824262.72727273},
          {:date_time=>"2018-11-09T00:00:00.000Z", :adtv=>39911139.54545455},
          {:date_time=>"2018-11-08T00:00:00.000Z", :adtv=>40218699.09090909},
          {:date_time=>"2018-11-07T00:00:00.000Z", :adtv=>40280851.81818182}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1, volume_key: :volume)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('adtv')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Average Daily Trading Volume')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period volume_key))
      end

      it 'Validates options' do
        valid_options = { period: 22, volume_key: :close }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(4)
      end
    end
  end
end
