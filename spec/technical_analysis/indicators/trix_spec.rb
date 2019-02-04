require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "TRIX" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Trix

    describe 'Triple Exponential Average' do
      it 'Calculates TRIX (15 day)' do
        output = indicator.calculate(input_data, period: 15, price_key: :close)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>-0.007522826289174942},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>-0.007639218329257057},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>-0.007682172922749195},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>-0.00767662212545961},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>-0.007665196848424279},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>-0.007658933006361239},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>-0.007775594696883065},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>-0.007833433859114468},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>-0.007824502562605692},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>-0.00776162437514068},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>-0.007643867247128558},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>-0.007455715388896471},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>-0.00735126292321306},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>-0.007332615495168546},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>-0.007365504921638632},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>-0.007428539823046746},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>-0.007473061875390961},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>-0.007537530463588133},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>-0.007622995995719011},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>-0.007673381215454718}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('trix')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Triple Exponential Average')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period price_key))
      end

      it 'Validates options' do
        valid_options = { period: 22, price_key: :close }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(11)
      end
    end
  end
end
