require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "MI" do
    input_data = SpecHelper.get_test_data(:high, :low)

    describe 'Simple Mass Index' do
      it 'Calculates MI' do
        output = TechnicalAnalysis::Mi.calculate(input_data, ema_period: 9, sum_period: 25)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>24.77520633216394},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>24.80084030980544},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>24.924292786436485},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>25.026285600546654},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>25.018142841959207},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>25.04245599370965},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>25.03284918462693},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>25.020764664334674},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>24.964776002066408},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>24.791003528125515},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>24.564590708470064},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>24.454674020826847},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>24.303447406952383},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>24.12156756268421},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>23.94958830559542},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>23.879826345759078},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>23.792012619835983},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>23.82241708019551},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>23.835760161850434},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>23.89261610689666},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>23.890966368346767},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>23.8163614080134},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>23.82917406071097}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Mi.calculate(input_data, ema_period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
