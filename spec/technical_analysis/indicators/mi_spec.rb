require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "MI" do
    input_data = SpecHelper.get_test_data(:high, :low)

    describe 'Simple Mass Index' do
      it 'Calculates MI' do
        output = TechnicalAnalysis::Mi.calculate(input_data, ema_period: 9, sum_period: 25)

        expected_output = [
          {:date=>"2018/12/06", :value=>23.82917406071097},
          {:date=>"2018/12/07", :value=>23.8163614080134},
          {:date=>"2018/12/10", :value=>23.890966368346767},
          {:date=>"2018/12/11", :value=>23.89261610689666},
          {:date=>"2018/12/12", :value=>23.835760161850434},
          {:date=>"2018/12/13", :value=>23.82241708019551},
          {:date=>"2018/12/14", :value=>23.792012619835983},
          {:date=>"2018/12/17", :value=>23.879826345759078},
          {:date=>"2018/12/18", :value=>23.94958830559542},
          {:date=>"2018/12/19", :value=>24.12156756268421},
          {:date=>"2018/12/20", :value=>24.303447406952383},
          {:date=>"2018/12/21", :value=>24.454674020826847},
          {:date=>"2018/12/24", :value=>24.564590708470064},
          {:date=>"2018/12/26", :value=>24.791003528125515},
          {:date=>"2018/12/27", :value=>24.964776002066408},
          {:date=>"2018/12/28", :value=>25.020764664334674},
          {:date=>"2018/12/31", :value=>25.03284918462693},
          {:date=>"2019/01/02", :value=>25.04245599370965},
          {:date=>"2019/01/03", :value=>25.018142841959207},
          {:date=>"2019/01/04", :value=>25.026285600546654},
          {:date=>"2019/01/07", :value=>24.924292786436485},
          {:date=>"2019/01/08", :value=>24.80084030980544},
          {:date=>"2019/01/09", :value=>24.77520633216394}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Mi.calculate(input_data, ema_period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
