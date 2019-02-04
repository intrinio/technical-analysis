require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "ADI" do
    indicator = TechnicalAnalysis::Adi

    describe 'Accumulation/Distribution Index' do
      it 'Calculates ADI' do

        input_data = SpecHelper.get_test_data(:volume, :high, :low, :close)
        output = indicator.calculate(input_data)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>-112451134.66006838},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>-135060226.53761944},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>-149339794.90125585},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>-170386118.17770624},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>-220800308.5532927},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>-139000081.24146464},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>-160289759.42328274},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>-155977335.67328295},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>-149563792.60023466},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>-191621153.9435182},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>-249091249.23371798},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>-215519041.4917826},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>-144651314.99705797},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>-109189734.6005822},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>-82088668.90680213},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>-84453563.11062376},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>-59826989.44514345},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>-23482456.813564237},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>-21169236.217537448},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>12348220.058324995},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>27031122.187761355},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>-25774650.00158758},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>13345403.439446371},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>-28184142.065140743},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>7310177.429459017},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>-30619198.70995107},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>-28229849.61904212},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>-16831219.815120786},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>-57716487.89688186},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>-87657844.24649628},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>-126035061.64521725},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>-104408223.70305927},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>-77157217.68155372},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>-42863658.35269459},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>-13921718.702957403},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>-31201198.431607798},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>-67251111.0548819},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>-19025685.861899547},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>14980297.36136794},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>59576412.70790268},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>53370009.30364728},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>52544543.51729703},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>20488006.51898352},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>8638028.433174696},
          {:date_time=>"2018-11-02T00:00:00.000Z", :value=>2052056.5039138943},
          {:date_time=>"2018-11-01T00:00:00.000Z", :value=>47686098.74235708},
          {:date_time=>"2018-10-31T00:00:00.000Z", :value=>-2596414.5729579534},
          {:date_time=>"2018-10-30T00:00:00.000Z", :value=>-9048353.606900878},
          {:date_time=>"2018-10-29T00:00:00.000Z", :value=>-22322304.45292461},
          {:date_time=>"2018-10-26T00:00:00.000Z", :value=>-17952613.497042313},
          {:date_time=>"2018-10-25T00:00:00.000Z", :value=>-16320985.571510637},
          {:date_time=>"2018-10-24T00:00:00.000Z", :value=>-25537009.286413625},
          {:date_time=>"2018-10-23T00:00:00.000Z", :value=>9915241.57013943},
          {:date_time=>"2018-10-22T00:00:00.000Z", :value=>-24060850.441556394},
          {:date_time=>"2018-10-19T00:00:00.000Z", :value=>-17555977.138388995},
          {:date_time=>"2018-10-18T00:00:00.000Z", :value=>-16955140.819851194},
          {:date_time=>"2018-10-17T00:00:00.000Z", :value=>-13591269.009762233},
          {:date_time=>"2018-10-16T00:00:00.000Z", :value=>-16341921.130974408},
          {:date_time=>"2018-10-15T00:00:00.000Z", :value=>-37374123.7894299},
          {:date_time=>"2018-10-12T00:00:00.000Z", :value=>-8288954.710482582},
          {:date_time=>"2018-10-11T00:00:00.000Z", :value=>-37713866.134323865},
          {:date_time=>"2018-10-10T00:00:00.000Z", :value=>-16199273.599504825},
          {:date_time=>"2018-10-09T00:00:00.000Z", :value=>22411774.711174767}
        ]

        expect(output).to eq(expected_output)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('adi')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Accumulation/Distribution Index')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq([])
      end

      it 'Validates options' do
        valid_options = {}
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = {}
        expect(indicator.min_data_size(options)).to eq(1)
      end
    end
  end
end
