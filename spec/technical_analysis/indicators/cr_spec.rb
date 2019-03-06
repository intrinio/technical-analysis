require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "CR" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Cr

    describe 'Cumulative Return' do
      it 'Calculates CR' do
        output = indicator.calculate(input_data, price_key: :close)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :cr=>-0.3242385507118614},
          {:date_time=>"2019-01-08T00:00:00.000Z", :cr=>-0.33552254595142594},
          {:date_time=>"2019-01-07T00:00:00.000Z", :cr=>-0.34795257195750867},
          {:date_time=>"2019-01-04T00:00:00.000Z", :cr=>-0.34649799444615864},
          {:date_time=>"2019-01-03T00:00:00.000Z", :cr=>-0.3732534050337198},
          {:date_time=>"2019-01-02T00:00:00.000Z", :cr=>-0.30391854365936444},
          {:date_time=>"2018-12-31T00:00:00.000Z", :cr=>-0.30471194957464626},
          {:date_time=>"2018-12-28T00:00:00.000Z", :cr=>-0.3113677436417332},
          {:date_time=>"2018-12-27T00:00:00.000Z", :cr=>-0.3117203684929695},
          {:date_time=>"2018-12-26T00:00:00.000Z", :cr=>-0.3072244016397056},
          {:date_time=>"2018-12-24T00:00:00.000Z", :cr=>-0.35280116366200903},
          {:date_time=>"2018-12-21T00:00:00.000Z", :cr=>-0.3356107021642351},
          {:date_time=>"2018-12-20T00:00:00.000Z", :cr=>-0.3087230572574602},
          {:date_time=>"2018-12-19T00:00:00.000Z", :cr=>-0.29082734605721344},
          {:date_time=>"2018-12-18T00:00:00.000Z", :cr=>-0.2679948869396571},
          {:date_time=>"2018-12-17T00:00:00.000Z", :cr=>-0.277383523603826},
          {:date_time=>"2018-12-14T00:00:00.000Z", :cr=>-0.2705954952175255},
          {:date_time=>"2018-12-13T00:00:00.000Z", :cr=>-0.2464847710142373},
          {:date_time=>"2018-12-12T00:00:00.000Z", :cr=>-0.2546392206990788},
          {:date_time=>"2018-12-11T00:00:00.000Z", :cr=>-0.2567108917000926},
          {:date_time=>"2018-12-10T00:00:00.000Z", :cr=>-0.2524353153788514},
          {:date_time=>"2018-12-07T00:00:00.000Z", :cr=>-0.25732798518975625},
          {:date_time=>"2018-12-06T00:00:00.000Z", :cr=>-0.22986732489972234},
          {:date_time=>"2018-12-04T00:00:00.000Z", :cr=>-0.2211839379380262},
          {:date_time=>"2018-12-03T00:00:00.000Z", :cr=>-0.185348437431128},
          {:date_time=>"2018-11-30T00:00:00.000Z", :cr=>-0.2128531758275664},
          {:date_time=>"2018-11-29T00:00:00.000Z", :cr=>-0.20857759950632518},
          {:date_time=>"2018-11-28T00:00:00.000Z", :cr=>-0.20245074271609295},
          {:date_time=>"2018-11-27T00:00:00.000Z", :cr=>-0.23198307400714063},
          {:date_time=>"2018-11-26T00:00:00.000Z", :cr=>-0.2303081059637678},
          {:date_time=>"2018-11-23T00:00:00.000Z", :cr=>-0.24057830475602773},
          {:date_time=>"2018-11-21T00:00:00.000Z", :cr=>-0.22078723498038524},
          {:date_time=>"2018-11-20T00:00:00.000Z", :cr=>-0.21990567285229431},
          {:date_time=>"2018-11-19T00:00:00.000Z", :cr=>-0.18076431436505483},
          {:date_time=>"2018-11-16T00:00:00.000Z", :cr=>-0.14695640675276592},
          {:date_time=>"2018-11-15T00:00:00.000Z", :cr=>-0.15630096531053028},
          {:date_time=>"2018-11-14T00:00:00.000Z", :cr=>-0.17662097236302726},
          {:date_time=>"2018-11-13T00:00:00.000Z", :cr=>-0.15268656058535732},
          {:date_time=>"2018-11-12T00:00:00.000Z", :cr=>-0.14413540794287485},
          {:date_time=>"2018-11-09T00:00:00.000Z", :cr=>-0.09873495834618948},
          {:date_time=>"2018-11-08T00:00:00.000Z", :cr=>-0.08101555957156079},
          {:date_time=>"2018-11-07T00:00:00.000Z", :cr=>-0.07458015603649674},
          {:date_time=>"2018-11-06T00:00:00.000Z", :cr=>-0.10182042579450784},
          {:date_time=>"2018-11-05T00:00:00.000Z", :cr=>-0.11142945299069952},
          {:date_time=>"2018-11-02T00:00:00.000Z", :cr=>-0.0854674483184203},
          {:date_time=>"2018-11-01T00:00:00.000Z", :cr=>-0.020496319478115244},
          {:date_time=>"2018-10-31T00:00:00.000Z", :cr=>-0.035306563230043594},
          {:date_time=>"2018-10-30T00:00:00.000Z", :cr=>-0.05981399039097277},
          {:date_time=>"2018-10-29T00:00:00.000Z", :cr=>-0.06448626966985496},
          {:date_time=>"2018-10-26T00:00:00.000Z", :cr=>-0.046590558469608113},
          {:date_time=>"2018-10-25T00:00:00.000Z", :cr=>-0.031163221228016014},
          {:date_time=>"2018-10-24T00:00:00.000Z", :cr=>-0.05192400934455856},
          {:date_time=>"2018-10-23T00:00:00.000Z", :cr=>-0.018248336051483294},
          {:date_time=>"2018-10-22T00:00:00.000Z", :cr=>-0.027416582183629384},
          {:date_time=>"2018-10-19T00:00:00.000Z", :cr=>-0.03332304844183895},
          {:date_time=>"2018-10-18T00:00:00.000Z", :cr=>-0.04782474544893549},
          {:date_time=>"2018-10-17T00:00:00.000Z", :cr=>-0.025036364437783783},
          {:date_time=>"2018-10-16T00:00:00.000Z", :cr=>-0.02080486622294706},
          {:date_time=>"2018-10-15T00:00:00.000Z", :cr=>-0.041918279190725924},
          {:date_time=>"2018-10-12T00:00:00.000Z", :cr=>-0.02098117864856522},
          {:date_time=>"2018-10-11T00:00:00.000Z", :cr=>-0.054745008154449756},
          {:date_time=>"2018-10-10T00:00:00.000Z", :cr=>-0.04632608983118081},
          {:date_time=>"2018-10-09T00:00:00.000Z", :cr=>0.0}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate([], price_key: :close)}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('cr')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Cumulative Return')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(price_key))
      end

      it 'Validates options' do
        valid_options = { price_key: :close }
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
