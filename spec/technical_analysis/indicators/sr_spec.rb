require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "SR" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)
    indicator = TechnicalAnalysis::Sr

    describe 'Stochastic Oscillator' do
      it 'Calculates SR (14 day)' do
        output = indicator.calculate(input_data, period: 14, signal_period: 3)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :value=>{:sr=>44.44007858546172, :sr_signal=>33.739408752366685}},
          {:date_time=>"2019-01-08T00:00:00.000Z", :value=>{:sr=>34.27340383862123, :sr_signal=>26.631612985573174}},
          {:date_time=>"2019-01-07T00:00:00.000Z", :value=>{:sr=>22.50474383301711, :sr_signal=>15.414319829465327}},
          {:date_time=>"2019-01-04T00:00:00.000Z", :value=>{:sr=>23.1166912850812, :sr_signal=>22.449561749124218}},
          {:date_time=>"2019-01-03T00:00:00.000Z", :value=>{:sr=>0.6215243702976702, :sr_signal=>29.04987430254469}},
          {:date_time=>"2019-01-02T00:00:00.000Z", :value=>{:sr=>43.61046959199379, :sr_signal=>41.21118809340517}},
          {:date_time=>"2018-12-31T00:00:00.000Z", :value=>{:sr=>42.917628945342614, :sr_signal=>38.09610922104404}},
          {:date_time=>"2018-12-28T00:00:00.000Z", :value=>{:sr=>37.105465742879105, :sr_signal=>36.300579364484854}},
          {:date_time=>"2018-12-27T00:00:00.000Z", :value=>{:sr=>34.2652329749104, :sr_signal=>24.155555094877986}},
          {:date_time=>"2018-12-26T00:00:00.000Z", :value=>{:sr=>37.531039375665074, :sr_signal=>13.772232369077116}},
          {:date_time=>"2018-12-24T00:00:00.000Z", :value=>{:sr=>0.6703929340585003, :sr_signal=>2.9825336838014445}},
          {:date_time=>"2018-12-21T00:00:00.000Z", :value=>{:sr=>3.1152647975077716, :sr_signal=>5.080152544595593}},
          {:date_time=>"2018-12-20T00:00:00.000Z", :value=>{:sr=>5.161943319838063, :sr_signal=>9.054487961785336}},
          {:date_time=>"2018-12-19T00:00:00.000Z", :value=>{:sr=>6.963249516440942, :sr_signal=>9.149838987845628}},
          {:date_time=>"2018-12-18T00:00:00.000Z", :value=>{:sr=>15.038271049077, :sr_signal=>10.145121695692445}},
          {:date_time=>"2018-12-17T00:00:00.000Z", :value=>{:sr=>5.447996398018944, :sr_signal=>16.886182356334803}},
          {:date_time=>"2018-12-14T00:00:00.000Z", :value=>{:sr=>9.94909763998139, :sr_signal=>23.970384081443694}},
          {:date_time=>"2018-12-13T00:00:00.000Z", :value=>{:sr=>35.26145303100408, :sr_signal=>28.8292457195742}},
          {:date_time=>"2018-12-12T00:00:00.000Z", :value=>{:sr=>26.700601573345605, :sr_signal=>24.711525960000667}},
          {:date_time=>"2018-12-11T00:00:00.000Z", :value=>{:sr=>24.525682554372914, :sr_signal=>16.048800203857994}},
          {:date_time=>"2018-12-10T00:00:00.000Z", :value=>{:sr=>22.908293752283477, :sr_signal=>13.89015200407954}},
          {:date_time=>"2018-12-07T00:00:00.000Z", :value=>{:sr=>0.712424304917594, :sr_signal=>14.928180772069608}},
          {:date_time=>"2018-12-06T00:00:00.000Z", :value=>{:sr=>18.049737955037553, :sr_signal=>32.719433096383845}},
          {:date_time=>"2018-12-04T00:00:00.000Z", :value=>{:sr=>26.022380056253674, :sr_signal=>36.07538954462583}},
          {:date_time=>"2018-12-03T00:00:00.000Z", :value=>{:sr=>54.0861812778603, :sr_signal=>36.063267521212616}},
          {:date_time=>"2018-11-30T00:00:00.000Z", :value=>{:sr=>28.117607299763502, :sr_signal=>26.965799836520265}},
          {:date_time=>"2018-11-29T00:00:00.000Z", :value=>{:sr=>25.986013986014044, :sr_signal=>20.92157984180065}},
          {:date_time=>"2018-11-28T00:00:00.000Z", :value=>{:sr=>26.79377822378325, :sr_signal=>15.905669844455621}},
          {:date_time=>"2018-11-27T00:00:00.000Z", :value=>{:sr=>9.984947315604659, :sr_signal=>7.140989430040055}},
          {:date_time=>"2018-11-26T00:00:00.000Z", :value=>{:sr=>10.938283993978956, :sr_signal=>4.922619471840783}},
          {:date_time=>"2018-11-23T00:00:00.000Z", :value=>{:sr=>0.49973698053655363, :sr_signal=>2.3224159491234997}},
          {:date_time=>"2018-11-21T00:00:00.000Z", :value=>{:sr=>3.329837441006842, :sr_signal=>2.931860503912096}},
          {:date_time=>"2018-11-20T00:00:00.000Z", :value=>{:sr=>3.137673425827104, :sr_signal=>8.775890351328327}},
          {:date_time=>"2018-11-19T00:00:00.000Z", :value=>{:sr=>2.32807064490234, :sr_signal=>12.744181659747374}},
          {:date_time=>"2018-11-16T00:00:00.000Z", :value=>{:sr=>20.86192698325554, :sr_signal=>12.764205325281347}},
          {:date_time=>"2018-11-15T00:00:00.000Z", :value=>{:sr=>15.04254735108424, :sr_signal=>6.651276276015249}},
          {:date_time=>"2018-11-14T00:00:00.000Z", :value=>{:sr=>2.388141641504267, :sr_signal=>2.0532129671343387}},
          {:date_time=>"2018-11-13T00:00:00.000Z", :value=>{:sr=>2.5231398354572394, :sr_signal=>9.31549269113536}},
          {:date_time=>"2018-11-12T00:00:00.000Z", :value=>{:sr=>1.2483574244415094, :sr_signal=>21.674753063199656}},
          {:date_time=>"2018-11-09T00:00:00.000Z", :value=>{:sr=>24.174980813507332, :sr_signal=>36.326426195958085}},
          {:date_time=>"2018-11-08T00:00:00.000Z", :value=>{:sr=>39.60092095165012, :sr_signal=>35.431056536198575}},
          {:date_time=>"2018-11-07T00:00:00.000Z", :value=>{:sr=>45.203376822716805, :sr_signal=>26.605269889997487}},
          {:date_time=>"2018-11-06T00:00:00.000Z", :value=>{:sr=>21.48887183422879, :sr_signal=>15.172229388808171}},
          {:date_time=>"2018-11-05T00:00:00.000Z", :value=>{:sr=>13.123561013046874, :sr_signal=>37.649110405476506}},
          {:date_time=>"2018-11-02T00:00:00.000Z", :value=>{:sr=>10.904255319148854, :sr_signal=>56.740227701017325}},
          {:date_time=>"2018-11-01T00:00:00.000Z", :value=>{:sr=>88.91951488423378, :sr_signal=>66.35428151414929}},
          {:date_time=>"2018-10-31T00:00:00.000Z", :value=>{:sr=>70.39691289966935, :sr_signal=>46.83290323914804}},
          {:date_time=>"2018-10-30T00:00:00.000Z", :value=>{:sr=>39.746416758544726, :sr_signal=>32.241290132123396}}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('sr')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Stochastic Oscillator')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period signal_period))
      end

      it 'Validates options' do
        valid_options = { period: 22, signal_period: 4 }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4, signal_period: 2 }
        expect(indicator.min_data_size(options)).to eq(5)
      end
    end
  end
end
