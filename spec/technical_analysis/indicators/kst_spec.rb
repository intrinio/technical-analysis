require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "KST" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'Know Sure Thing' do
      it 'Calculates KST' do
        output = TechnicalAnalysis::Kst.calculate(input_data, roc1: 10, roc2: 15, roc3: 20, roc4: 30, sma1: 10, sma2: 10, sma3: 10, sma4: 15, price_key: :close)

        expected_output = [
          {:date=>"2018/12/11", :value=>-150.14198896419614},
          {:date=>"2018/12/12", :value=>-146.67417088368043},
          {:date=>"2018/12/13", :value=>-143.06704590371226},
          {:date=>"2018/12/14", :value=>-141.6235541026754},
          {:date=>"2018/12/17", :value=>-140.69442915235626},
          {:date=>"2018/12/18", :value=>-141.36803679622636},
          {:date=>"2018/12/19", :value=>-141.34365936138443},
          {:date=>"2018/12/20", :value=>-143.4025404878081},
          {:date=>"2018/12/21", :value=>-145.9029270207904},
          {:date=>"2018/12/24", :value=>-150.769274028613},
          {:date=>"2018/12/26", :value=>-151.25248412993977},
          {:date=>"2018/12/27", :value=>-152.69243922992774},
          {:date=>"2018/12/28", :value=>-154.278039839607},
          {:date=>"2018/12/31", :value=>-152.43337072156913},
          {:date=>"2019/01/02", :value=>-150.77021075475108},
          {:date=>"2019/01/03", :value=>-157.0260814891967},
          {:date=>"2019/01/04", :value=>-157.83675223915662},
          {:date=>"2019/01/07", :value=>-155.71040741442587},
          {:date=>"2019/01/08", :value=>-148.9261153101682},
          {:date=>"2019/01/09", :value=>-140.9140022298261}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        roc4 = 60
        sma4 = 30
        expect {TechnicalAnalysis::Kst.calculate(input_data, roc4: roc4, sma4: sma4, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
