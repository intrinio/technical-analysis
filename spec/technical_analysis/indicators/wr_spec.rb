require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "WR" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)
    indicator = TechnicalAnalysis::Wr

    describe 'Williams %R' do
      it 'Calculates Williams %R' do
        output = indicator.calculate(input_data, period: 14)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :wr=>-55.55992141453828},
          {:date_time=>"2019-01-08T00:00:00.000Z", :wr=>-65.72659616137877},
          {:date_time=>"2019-01-07T00:00:00.000Z", :wr=>-77.4952561669829},
          {:date_time=>"2019-01-04T00:00:00.000Z", :wr=>-76.88330871491881},
          {:date_time=>"2019-01-03T00:00:00.000Z", :wr=>-99.37847562970234},
          {:date_time=>"2019-01-02T00:00:00.000Z", :wr=>-56.38953040800621},
          {:date_time=>"2018-12-31T00:00:00.000Z", :wr=>-57.082371054657386},
          {:date_time=>"2018-12-28T00:00:00.000Z", :wr=>-62.8945342571209},
          {:date_time=>"2018-12-27T00:00:00.000Z", :wr=>-65.7347670250896},
          {:date_time=>"2018-12-26T00:00:00.000Z", :wr=>-62.468960624334926},
          {:date_time=>"2018-12-24T00:00:00.000Z", :wr=>-99.32960706594149},
          {:date_time=>"2018-12-21T00:00:00.000Z", :wr=>-96.88473520249222},
          {:date_time=>"2018-12-20T00:00:00.000Z", :wr=>-94.83805668016194},
          {:date_time=>"2018-12-19T00:00:00.000Z", :wr=>-93.03675048355906},
          {:date_time=>"2018-12-18T00:00:00.000Z", :wr=>-84.961728950923},
          {:date_time=>"2018-12-17T00:00:00.000Z", :wr=>-94.55200360198106},
          {:date_time=>"2018-12-14T00:00:00.000Z", :wr=>-90.0509023600186},
          {:date_time=>"2018-12-13T00:00:00.000Z", :wr=>-64.73854696899592},
          {:date_time=>"2018-12-12T00:00:00.000Z", :wr=>-73.29939842665439},
          {:date_time=>"2018-12-11T00:00:00.000Z", :wr=>-75.47431744562708},
          {:date_time=>"2018-12-10T00:00:00.000Z", :wr=>-77.09170624771653},
          {:date_time=>"2018-12-07T00:00:00.000Z", :wr=>-99.28757569508241},
          {:date_time=>"2018-12-06T00:00:00.000Z", :wr=>-81.95026204496244},
          {:date_time=>"2018-12-04T00:00:00.000Z", :wr=>-73.97761994374633},
          {:date_time=>"2018-12-03T00:00:00.000Z", :wr=>-45.9138187221397},
          {:date_time=>"2018-11-30T00:00:00.000Z", :wr=>-71.8823927002365},
          {:date_time=>"2018-11-29T00:00:00.000Z", :wr=>-74.01398601398596},
          {:date_time=>"2018-11-28T00:00:00.000Z", :wr=>-73.20622177621675},
          {:date_time=>"2018-11-27T00:00:00.000Z", :wr=>-90.01505268439534},
          {:date_time=>"2018-11-26T00:00:00.000Z", :wr=>-89.06171600602104},
          {:date_time=>"2018-11-23T00:00:00.000Z", :wr=>-99.50026301946345},
          {:date_time=>"2018-11-21T00:00:00.000Z", :wr=>-96.67016255899316},
          {:date_time=>"2018-11-20T00:00:00.000Z", :wr=>-96.8623265741729},
          {:date_time=>"2018-11-19T00:00:00.000Z", :wr=>-97.67192935509766},
          {:date_time=>"2018-11-16T00:00:00.000Z", :wr=>-79.13807301674446},
          {:date_time=>"2018-11-15T00:00:00.000Z", :wr=>-84.95745264891575},
          {:date_time=>"2018-11-14T00:00:00.000Z", :wr=>-97.61185835849572},
          {:date_time=>"2018-11-13T00:00:00.000Z", :wr=>-97.47686016454276},
          {:date_time=>"2018-11-12T00:00:00.000Z", :wr=>-98.75164257555849},
          {:date_time=>"2018-11-09T00:00:00.000Z", :wr=>-75.82501918649267},
          {:date_time=>"2018-11-08T00:00:00.000Z", :wr=>-60.39907904834988},
          {:date_time=>"2018-11-07T00:00:00.000Z", :wr=>-54.79662317728319},
          {:date_time=>"2018-11-06T00:00:00.000Z", :wr=>-78.51112816577121},
          {:date_time=>"2018-11-05T00:00:00.000Z", :wr=>-86.87643898695312},
          {:date_time=>"2018-11-02T00:00:00.000Z", :wr=>-89.09574468085114},
          {:date_time=>"2018-11-01T00:00:00.000Z", :wr=>-11.080485115766221},
          {:date_time=>"2018-10-31T00:00:00.000Z", :wr=>-29.60308710033065},
          {:date_time=>"2018-10-30T00:00:00.000Z", :wr=>-60.253583241455274},
          {:date_time=>"2018-10-29T00:00:00.000Z", :wr=>-69.64461994076994},
          {:date_time=>"2018-10-26T00:00:00.000Z", :wr=>-73.3779264214046}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('wr')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Williams %R')
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
        expect(indicator.min_data_size(options)).to eq(4)
      end
    end
  end
end
