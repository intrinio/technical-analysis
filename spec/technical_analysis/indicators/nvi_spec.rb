require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "NVI" do
    input_data = SpecHelper.get_test_data(:close, :volume)
    indicator = TechnicalAnalysis::Nvi

    describe 'Negative Volume Index' do
      it 'Calculates NVI' do
        output = indicator.calculate(input_data)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :nvi=>1002.8410612825647},
          {:date_time=>"2019-01-08T00:00:00.000Z", :nvi=>1002.8410612825647},
          {:date_time=>"2019-01-07T00:00:00.000Z", :nvi=>1000.9347542454526},
          {:date_time=>"2019-01-04T00:00:00.000Z", :nvi=>1001.1573361960799},
          {:date_time=>"2019-01-03T00:00:00.000Z", :nvi=>996.888400265283},
          {:date_time=>"2019-01-02T00:00:00.000Z", :nvi=>996.888400265283},
          {:date_time=>"2018-12-31T00:00:00.000Z", :nvi=>996.888400265283},
          {:date_time=>"2018-12-28T00:00:00.000Z", :nvi=>995.9218765502475},
          {:date_time=>"2018-12-27T00:00:00.000Z", :nvi=>995.8706437612625},
          {:date_time=>"2018-12-26T00:00:00.000Z", :nvi=>996.519622574013},
          {:date_time=>"2018-12-24T00:00:00.000Z", :nvi=>996.519622574013},
          {:date_time=>"2018-12-21T00:00:00.000Z", :nvi=>999.1070305219995},
          {:date_time=>"2018-12-20T00:00:00.000Z", :nvi=>999.1070305219995},
          {:date_time=>"2018-12-19T00:00:00.000Z", :nvi=>999.1070305219995},
          {:date_time=>"2018-12-18T00:00:00.000Z", :nvi=>999.1070305219995},
          {:date_time=>"2018-12-17T00:00:00.000Z", :nvi=>997.8077746966976},
          {:date_time=>"2018-12-14T00:00:00.000Z", :nvi=>997.8077746966976},
          {:date_time=>"2018-12-13T00:00:00.000Z", :nvi=>997.8077746966976},
          {:date_time=>"2018-12-12T00:00:00.000Z", :nvi=>996.713747493859},
          {:date_time=>"2018-12-11T00:00:00.000Z", :nvi=>996.4350307767862},
          {:date_time=>"2018-12-10T00:00:00.000Z", :nvi=>997.0069647390503},
          {:date_time=>"2018-12-07T00:00:00.000Z", :nvi=>997.0069647390503},
          {:date_time=>"2018-12-06T00:00:00.000Z", :nvi=>1000.5726698672554},
          {:date_time=>"2018-12-04T00:00:00.000Z", :nvi=>1000.5726698672554},
          {:date_time=>"2018-12-03T00:00:00.000Z", :nvi=>1000.5726698672554},
          {:date_time=>"2018-11-30T00:00:00.000Z", :nvi=>1000.5726698672554},
          {:date_time=>"2018-11-29T00:00:00.000Z", :nvi=>1001.1129093548633},
          {:date_time=>"2018-11-28T00:00:00.000Z", :nvi=>1001.8811198113682},
          {:date_time=>"2018-11-27T00:00:00.000Z", :nvi=>1001.8811198113682},
          {:date_time=>"2018-11-26T00:00:00.000Z", :nvi=>1002.0987352047939},
          {:date_time=>"2018-11-23T00:00:00.000Z", :nvi=>1002.0987352047939},
          {:date_time=>"2018-11-21T00:00:00.000Z", :nvi=>1004.6386152817257},
          {:date_time=>"2018-11-20T00:00:00.000Z", :nvi=>1004.7516224011742},
          {:date_time=>"2018-11-19T00:00:00.000Z", :nvi=>1004.7516224011742},
          {:date_time=>"2018-11-16T00:00:00.000Z", :nvi=>1004.7516224011742},
          {:date_time=>"2018-11-15T00:00:00.000Z", :nvi=>1003.6440522637729},
          {:date_time=>"2018-11-14T00:00:00.000Z", :nvi=>1001.1761721781198},
          {:date_time=>"2018-11-13T00:00:00.000Z", :nvi=>1001.1761721781198},
          {:date_time=>"2018-11-12T00:00:00.000Z", :nvi=>1002.1752966566695},
          {:date_time=>"2018-11-09T00:00:00.000Z", :nvi=>1002.1752966566695},
          {:date_time=>"2018-11-08T00:00:00.000Z", :nvi=>1002.1752966566695},
          {:date_time=>"2018-11-07T00:00:00.000Z", :nvi=>1002.8707003242093},
          {:date_time=>"2018-11-06T00:00:00.000Z", :nvi=>1002.8707003242093},
          {:date_time=>"2018-11-05T00:00:00.000Z", :nvi=>1001.7892974768458},
          {:date_time=>"2018-11-02T00:00:00.000Z", :nvi=>1004.6281253156736},
          {:date_time=>"2018-11-01T00:00:00.000Z", :nvi=>1004.6281253156736},
          {:date_time=>"2018-10-31T00:00:00.000Z", :nvi=>1004.6281253156736},
          {:date_time=>"2018-10-30T00:00:00.000Z", :nvi=>1004.6281253156736},
          {:date_time=>"2018-10-29T00:00:00.000Z", :nvi=>1004.1286907133366},
          {:date_time=>"2018-10-26T00:00:00.000Z", :nvi=>1006.0057133670583},
          {:date_time=>"2018-10-25T00:00:00.000Z", :nvi=>1006.0057133670583},
          {:date_time=>"2018-10-24T00:00:00.000Z", :nvi=>1003.8159323451605},
          {:date_time=>"2018-10-23T00:00:00.000Z", :nvi=>1003.8159323451605},
          {:date_time=>"2018-10-22T00:00:00.000Z", :nvi=>1003.8159323451605},
          {:date_time=>"2018-10-19T00:00:00.000Z", :nvi=>1003.2049250951491},
          {:date_time=>"2018-10-18T00:00:00.000Z", :nvi=>1003.2049250951491},
          {:date_time=>"2018-10-17T00:00:00.000Z", :nvi=>1003.2049250951491},
          {:date_time=>"2018-10-16T00:00:00.000Z", :nvi=>1003.6370655407939},
          {:date_time=>"2018-10-15T00:00:00.000Z", :nvi=>1001.4333482054976},
          {:date_time=>"2018-10-12T00:00:00.000Z", :nvi=>1003.5719281883889},
          {:date_time=>"2018-10-11T00:00:00.000Z", :nvi=>1000.0},
          {:date_time=>"2018-10-10T00:00:00.000Z", :nvi=>1000.0},
          {:date_time=>"2018-10-09T00:00:00.000Z", :nvi=>1000.0}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate([])}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('nvi')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Negative Volume Index')
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
        expect(indicator.min_data_size(options)).to eq(1)
      end
    end
  end
end
