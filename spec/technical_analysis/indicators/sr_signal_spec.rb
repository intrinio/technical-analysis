require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "SR Signal" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)

    describe 'Stochastic Oscillator Signal' do
      it 'Calculates 14 day SR Signal using 3 day SMA' do
        output = TechnicalAnalysis::SrSignal.calculate(input_data, period: 14, sma_period: 3)

        expected_output = [
          {:date=>"2018/10/30", :value=>32.241290132123396},
          {:date=>"2018/10/31", :value=>46.83290323914804},
          {:date=>"2018/11/01", :value=>66.35428151414929},
          {:date=>"2018/11/02", :value=>56.740227701017325},
          {:date=>"2018/11/05", :value=>37.649110405476506},
          {:date=>"2018/11/06", :value=>15.172229388808171},
          {:date=>"2018/11/07", :value=>26.605269889997487},
          {:date=>"2018/11/08", :value=>35.431056536198575},
          {:date=>"2018/11/09", :value=>36.326426195958085},
          {:date=>"2018/11/12", :value=>21.674753063199656},
          {:date=>"2018/11/13", :value=>9.31549269113536},
          {:date=>"2018/11/14", :value=>2.0532129671343387},
          {:date=>"2018/11/15", :value=>6.651276276015249},
          {:date=>"2018/11/16", :value=>12.764205325281347},
          {:date=>"2018/11/19", :value=>12.744181659747374},
          {:date=>"2018/11/20", :value=>8.775890351328327},
          {:date=>"2018/11/21", :value=>2.931860503912096},
          {:date=>"2018/11/23", :value=>2.3224159491234997},
          {:date=>"2018/11/26", :value=>4.922619471840783},
          {:date=>"2018/11/27", :value=>7.140989430040055},
          {:date=>"2018/11/28", :value=>15.905669844455621},
          {:date=>"2018/11/29", :value=>20.92157984180065},
          {:date=>"2018/11/30", :value=>26.965799836520265},
          {:date=>"2018/12/03", :value=>36.063267521212616},
          {:date=>"2018/12/04", :value=>36.07538954462583},
          {:date=>"2018/12/06", :value=>32.719433096383845},
          {:date=>"2018/12/07", :value=>14.928180772069608},
          {:date=>"2018/12/10", :value=>13.89015200407954},
          {:date=>"2018/12/11", :value=>16.048800203857994},
          {:date=>"2018/12/12", :value=>24.711525960000667},
          {:date=>"2018/12/13", :value=>28.8292457195742},
          {:date=>"2018/12/14", :value=>23.970384081443694},
          {:date=>"2018/12/17", :value=>16.886182356334803},
          {:date=>"2018/12/18", :value=>10.145121695692445},
          {:date=>"2018/12/19", :value=>9.149838987845628},
          {:date=>"2018/12/20", :value=>9.054487961785336},
          {:date=>"2018/12/21", :value=>5.080152544595593},
          {:date=>"2018/12/24", :value=>2.9825336838014445},
          {:date=>"2018/12/26", :value=>13.772232369077116},
          {:date=>"2018/12/27", :value=>24.155555094877986},
          {:date=>"2018/12/28", :value=>36.300579364484854},
          {:date=>"2018/12/31", :value=>38.09610922104404},
          {:date=>"2019/01/02", :value=>41.21118809340517},
          {:date=>"2019/01/03", :value=>29.04987430254469},
          {:date=>"2019/01/04", :value=>22.449561749124218},
          {:date=>"2019/01/07", :value=>15.414319829465327},
          {:date=>"2019/01/08", :value=>26.631612985573174},
          {:date=>"2019/01/09", :value=>33.739408752366685},
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::SrSignal.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
