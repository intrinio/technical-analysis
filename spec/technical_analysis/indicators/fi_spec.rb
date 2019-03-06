require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "FI" do
    input_data = SpecHelper.get_test_data(:close, :volume)
    indicator = TechnicalAnalysis::Fi

    describe 'Forced Index' do
      it 'Calculates FI' do
        output = indicator.calculate(input_data)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :fi=>115287987.2000001},
          {:date_time=>"2019-01-08T00:00:00.000Z", :fi=>114556606.19999972},
          {:date_time=>"2019-01-07T00:00:00.000Z", :fi=>-18008575.19999913},
          {:date_time=>"2019-01-04T00:00:00.000Z", :fi=>348561555.4999996},
          {:date_time=>"2019-01-03T00:00:00.000Z", :fi=>-1433110593.199999},
          {:date_time=>"2019-01-02T00:00:00.000Z", :fi=>6414672.59999923},
          {:date_time=>"2018-12-31T00:00:00.000Z", :fi=>52094078.90000067},
          {:date_time=>"2018-12-28T00:00:00.000Z", :fi=>3339247.9999993355},
          {:date_time=>"2018-12-27T00:00:00.000Z", :fi=>-52641026.99999906},
          {:date_time=>"2018-12-26T00:00:00.000Z", :fi=>601104008.9999986},
          {:date_time=>"2018-12-24T00:00:00.000Z", :fi=>-144959996.99999917},
          {:date_time=>"2018-12-21T00:00:00.000Z", :fi=>-582537190.0000021},
          {:date_time=>"2018-12-20T00:00:00.000Z", :fi=>-261456813.7999983},
          {:date_time=>"2018-12-19T00:00:00.000Z", :fi=>-246555930.60000032},
          {:date_time=>"2018-12-18T00:00:00.000Z", :fi=>71894933.69999984},
          {:date_time=>"2018-12-17T00:00:00.000Z", :fi=>-66605646.799999654},
          {:date_time=>"2018-12-14T00:00:00.000Z", :fi=>-222193369.19999996},
          {:date_time=>"2018-12-13T00:00:00.000Z", :fi=>58745288.49999982},
          {:date_time=>"2018-12-12T00:00:00.000Z", :fi=>16673099.59999996},
          {:date_time=>"2018-12-11T00:00:00.000Z", :fi=>-44588998.799999945},
          {:date_time=>"2018-12-10T00:00:00.000Z", :fi=>68552489.99999909},
          {:date_time=>"2018-12-07T00:00:00.000Z", :fi=>-259658176.39999956},
          {:date_time=>"2018-12-06T00:00:00.000Z", :fi=>-84128672.69999996},
          {:date_time=>"2018-12-04T00:00:00.000Z", :fi=>-334478362.4999998},
          {:date_time=>"2018-12-03T00:00:00.000Z", :fi=>252955247.99999923},
          {:date_time=>"2018-11-30T00:00:00.000Z", :fi=>-38241532.19999996},
          {:date_time=>"2018-11-29T00:00:00.000Z", :fi=>-57717776.19999944},
          {:date_time=>"2018-11-28T00:00:00.000Z", :fi=>307809724.99999946},
          {:date_time=>"2018-11-27T00:00:00.000Z", :fi=>-15639333.199999813},
          {:date_time=>"2018-11-26T00:00:00.000Z", :fi=>104063205.60000056},
          {:date_time=>"2018-11-23T00:00:00.000Z", :fi=>-106071625.30000022},
          {:date_time=>"2018-11-21T00:00:00.000Z", :fi=>-6219247.999999646},
          {:date_time=>"2018-11-20T00:00:00.000Z", :fi=>-600986678.4000016},
          {:date_time=>"2018-11-19T00:00:00.000Z", :fi=>-319277709.3999995},
          {:date_time=>"2018-11-16T00:00:00.000Z", :fi=>76725619.60000016},
          {:date_time=>"2018-11-15T00:00:00.000Z", :fi=>213312352.5999993},
          {:date_time=>"2018-11-14T00:00:00.000Z", :fi=>-328772056.1999987},
          {:date_time=>"2018-11-13T00:00:00.000Z", :fi=>-90647877.39999989},
          {:date_time=>"2018-11-12T00:00:00.000Z", :fi=>-525207609.0000006},
          {:date_time=>"2018-11-09T00:00:00.000Z", :fi=>-137957395.20000035},
          {:date_time=>"2018-11-08T00:00:00.000Z", :fi=>-36922334.19999948},
          {:date_time=>"2018-11-07T00:00:00.000Z", :fi=>205742335.19999927},
          {:date_time=>"2018-11-06T00:00:00.000Z", :fi=>69268889.60000022},
          {:date_time=>"2018-11-05T00:00:00.000Z", :fi=>-389165081.2999991},
          {:date_time=>"2018-11-02T00:00:00.000Z", :fi=>-1342026294.4000008},
          {:date_time=>"2018-11-01T00:00:00.000Z", :fi=>177925675.1999992},
          {:date_time=>"2018-10-31T00:00:00.000Z", :fi=>211373463.60000008},
          {:date_time=>"2018-10-30T00:00:00.000Z", :fi=>38677205.80000009},
          {:date_time=>"2018-10-29T00:00:00.000Z", :fi=>-185597581.4000001},
          {:date_time=>"2018-10-26T00:00:00.000Z", :fi=>-165170950.0},
          {:date_time=>"2018-10-25T00:00:00.000Z", :fi=>136718771.40000024},
          {:date_time=>"2018-10-24T00:00:00.000Z", :fi=>-305539796.7999995},
          {:date_time=>"2018-10-23T00:00:00.000Z", :fi=>80456833.59999938},
          {:date_time=>"2018-10-22T00:00:00.000Z", :fi=>38527063.6000001},
          {:date_time=>"2018-10-19T00:00:00.000Z", :fi=>108156545.69999973},
          {:date_time=>"2018-10-18T00:00:00.000Z", :fi=>-167452577.5999996},
          {:date_time=>"2018-10-17T00:00:00.000Z", :fi=>-21785164.80000018},
          {:date_time=>"2018-10-16T00:00:00.000Z", :fi=>137964214.49999976},
          {:date_time=>"2018-10-15T00:00:00.000Z", :fi=>-143832137.5},
          {:date_time=>"2018-10-12T00:00:00.000Z", :fi=>302529938.200001},
          {:date_time=>"2018-10-11T00:00:00.000Z", :fi=>-101043431.20000133},
          {:date_time=>"2018-10-10T00:00:00.000Z", :fi=>-431793575.69999963}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate([])}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('fi')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Force Index')
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
        expect { indicator.validate_options(invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = {}
        expect(indicator.min_data_size(options)).to eq(2)
      end
    end
  end
end
