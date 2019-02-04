require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "EVM" do
    input_data = SpecHelper.get_test_data(:high, :low, :volume)
    indicator = TechnicalAnalysis::Evm

    describe 'Ease of Movement' do
      it 'Calculates EVM (14 day)' do
        output = indicator.calculate(input_data, period: 14)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>-6.497226050937367},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>-7.7025655861800235},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>-10.852331038262774},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>-13.901372232239117},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>-14.868322149693872},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>-10.542472341445862},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>-7.266128029998595},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>-11.754905920393293},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>-15.149439471732872},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>-21.397258702024285},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>-29.127850557035778},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>-21.640253827328284},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>-19.510117531121228},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>-14.184550665717635},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>-5.583810139052782},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>-5.714363954096145},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>-5.49920090817078},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>-8.427863395925653},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>-8.897024349696329},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>-15.409243349973261},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>-21.68916026908629},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>-15.003602992747133},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>-14.327931101318542},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>-13.565693513893978},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>-11.780616477806618},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>-20.874548142667777},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>-23.304959556064855},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>-23.906907831421474},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>-24.18360420308819},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>-23.02094878061384},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>-27.26817615617346},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>-28.2247053700715},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>-27.37028760395389},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>-16.94506299946587},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>-13.43297156412281},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>-23.978202090280167},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>-26.374761082588922},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>-22.593717509723117},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>-19.69000228424736},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>-16.918604972309158},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>-11.567473480653877},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>-10.367227984759097},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>-22.183583990006944},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>-22.338003197707696},
          {:date_time=>"2018-11-02T00:00:00.000Z", :value=>-16.2797807192085},
          {:date_time=>"2018-11-01T00:00:00.000Z", :value=>-10.135395436615527},
          {:date_time=>"2018-10-31T00:00:00.000Z", :value=>-6.606596973217312},
          {:date_time=>"2018-10-30T00:00:00.000Z", :value=>-16.275660385464448},
          {:date_time=>"2018-10-29T00:00:00.000Z", :value=>-21.877975231994814}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+2)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('evm')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Ease of Movement')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period))
      end

      it 'Validates options' do
        valid_options = { period: 22 }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(5)
      end
    end
  end
end
