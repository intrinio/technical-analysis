require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "TRIX" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Triple Exponential Average' do
      it 'Calculates TRIX (15 day)' do
        output = TechnicalAnalysis::Trix.calculate(input_data, period: 15, price_key: :close)

        expected_output = [
          {:date=>"2018/12/11", :value=>-0.007673381215454718},
          {:date=>"2018/12/12", :value=>-0.007622995995719011},
          {:date=>"2018/12/13", :value=>-0.007537530463588133},
          {:date=>"2018/12/14", :value=>-0.007473061875390961},
          {:date=>"2018/12/17", :value=>-0.007428539823046746},
          {:date=>"2018/12/18", :value=>-0.007365504921638632},
          {:date=>"2018/12/19", :value=>-0.007332615495168546},
          {:date=>"2018/12/20", :value=>-0.00735126292321306},
          {:date=>"2018/12/21", :value=>-0.007455715388896471},
          {:date=>"2018/12/24", :value=>-0.007643867247128558},
          {:date=>"2018/12/26", :value=>-0.00776162437514068},
          {:date=>"2018/12/27", :value=>-0.007824502562605692},
          {:date=>"2018/12/28", :value=>-0.007833433859114468},
          {:date=>"2018/12/31", :value=>-0.007775594696883065},
          {:date=>"2019/01/02", :value=>-0.007658933006361239},
          {:date=>"2019/01/03", :value=>-0.007665196848424279},
          {:date=>"2019/01/04", :value=>-0.00767662212545961},
          {:date=>"2019/01/07", :value=>-0.007682172922749195},
          {:date=>"2019/01/08", :value=>-0.007639218329257057},
          {:date=>"2019/01/09", :value=>-0.007522826289174942}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Trix.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
