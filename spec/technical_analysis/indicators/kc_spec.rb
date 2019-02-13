require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "KC" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)
    indicator = TechnicalAnalysis::Kc

    describe 'Keltner Channel' do
      it 'Calculates KC (10 day)' do
        output = indicator.calculate(input_data, period: 10)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :lower_band=>147.1630066666667, :middle_band=>151.9909966666667, :upper_band=>156.8189866666667},
          {:date_time=>"2019-01-08T00:00:00.000Z", :lower_band=>146.74034, :middle_band=>151.57433, :upper_band=>156.40832},
          {:date_time=>"2019-01-07T00:00:00.000Z", :lower_band=>146.46500666666665, :middle_band=>151.82199666666665, :upper_band=>157.17898666666665},
          {:date_time=>"2019-01-04T00:00:00.000Z", :lower_band=>147.12967333333333, :middle_band=>152.87466333333333, :upper_band=>158.61965333333333},
          {:date_time=>"2019-01-03T00:00:00.000Z", :lower_band=>148.32933333333335, :middle_band=>154.43533333333335, :upper_band=>160.54133333333334},
          {:date_time=>"2019-01-02T00:00:00.000Z", :lower_band=>150.65666666666667, :middle_band=>156.70466666666667, :upper_band=>162.75266666666667},
          {:date_time=>"2018-12-31T00:00:00.000Z", :lower_band=>151.35733333333334, :middle_band=>157.50533333333334, :upper_band=>163.65333333333334},
          {:date_time=>"2018-12-28T00:00:00.000Z", :lower_band=>152.14066666666668, :middle_band=>158.38066666666668, :upper_band=>164.6206666666667},
          {:date_time=>"2018-12-27T00:00:00.000Z", :lower_band=>153.69466666666665, :middle_band=>159.83966666666666, :upper_band=>165.98466666666667},
          {:date_time=>"2018-12-26T00:00:00.000Z", :lower_band=>155.643, :middle_band=>161.408, :upper_band=>167.17299999999997},
          {:date_time=>"2018-12-24T00:00:00.000Z", :lower_band=>157.75833333333333, :middle_band=>162.9513333333333, :upper_band=>168.1443333333333},
          {:date_time=>"2018-12-21T00:00:00.000Z", :lower_band=>159.51333333333332, :middle_band=>164.8863333333333, :upper_band=>170.2593333333333},
          {:date_time=>"2018-12-20T00:00:00.000Z", :lower_band=>161.50599999999997, :middle_band=>166.64499999999998, :upper_band=>171.784},
          {:date_time=>"2018-12-19T00:00:00.000Z", :lower_band=>163.27366666666666, :middle_band=>168.16766666666666, :upper_band=>173.06166666666667},
          {:date_time=>"2018-12-18T00:00:00.000Z", :lower_band=>165.09500666666668, :middle_band=>169.76499666666666, :upper_band=>174.43498666666665},
          {:date_time=>"2018-12-17T00:00:00.000Z", :lower_band=>166.80200666666667, :middle_band=>171.53099666666668, :upper_band=>176.2599866666667},
          {:date_time=>"2018-12-14T00:00:00.000Z", :lower_band=>168.39800666666667, :middle_band=>172.89499666666666, :upper_band=>177.39198666666664},
          {:date_time=>"2018-12-13T00:00:00.000Z", :lower_band=>169.60834, :middle_band=>174.23533, :upper_band=>178.86232},
          {:date_time=>"2018-12-12T00:00:00.000Z", :lower_band=>170.07734, :middle_band=>175.03833, :upper_band=>179.99932},
          {:date_time=>"2018-12-11T00:00:00.000Z", :lower_band=>170.30667333333332, :middle_band=>175.36666333333332, :upper_band=>180.42665333333332},
          {:date_time=>"2018-12-10T00:00:00.000Z", :lower_band=>170.73033999999998, :middle_band=>175.78033, :upper_band=>180.83032},
          {:date_time=>"2018-12-07T00:00:00.000Z", :lower_band=>171.55567333333335, :middle_band=>176.37916333333334, :upper_band=>181.20265333333333},
          {:date_time=>"2018-12-06T00:00:00.000Z", :lower_band=>172.54667333333333, :middle_band=>177.12316333333334, :upper_band=>181.69965333333334},
          {:date_time=>"2018-12-04T00:00:00.000Z", :lower_band=>172.85467333333332, :middle_band=>177.59116333333333, :upper_band=>182.32765333333333},
          {:date_time=>"2018-12-03T00:00:00.000Z", :lower_band=>173.76899999999998, :middle_band=>178.4645, :upper_band=>183.16},
          {:date_time=>"2018-11-30T00:00:00.000Z", :lower_band=>174.4907, :middle_band=>179.36415, :upper_band=>184.2376},
          {:date_time=>"2018-11-29T00:00:00.000Z", :lower_band=>175.45836666666665, :middle_band=>180.50881666666666, :upper_band=>185.55926666666667},
          {:date_time=>"2018-11-28T00:00:00.000Z", :lower_band=>176.01870000000002, :middle_band=>181.41415, :upper_band=>186.8096},
          {:date_time=>"2018-11-27T00:00:00.000Z", :lower_band=>177.53838, :middle_band=>182.87081999999998, :upper_band=>188.20325999999997},
          {:date_time=>"2018-11-26T00:00:00.000Z", :lower_band=>179.58538000000001, :middle_band=>185.13482000000002, :upper_band=>190.68426000000002},
          {:date_time=>"2018-11-23T00:00:00.000Z", :lower_band=>182.7750466666667, :middle_band=>188.23148666666668, :upper_band=>193.68792666666667},
          {:date_time=>"2018-11-21T00:00:00.000Z", :lower_band=>186.36671333333337, :middle_band=>191.71065333333337, :upper_band=>197.05459333333337},
          {:date_time=>"2018-11-20T00:00:00.000Z", :lower_band=>189.16371333333333, :middle_band=>194.72865333333334, :upper_band=>200.29359333333335},
          {:date_time=>"2018-11-19T00:00:00.000Z", :lower_band=>191.99738, :middle_band=>197.26932, :upper_band=>202.54126},
          {:date_time=>"2018-11-16T00:00:00.000Z", :lower_band=>193.36638000000002, :middle_band=>198.68932, :upper_band=>204.01226},
          {:date_time=>"2018-11-15T00:00:00.000Z", :lower_band=>194.71534666666665, :middle_band=>200.30933666666664, :upper_band=>205.90332666666663},
          {:date_time=>"2018-11-14T00:00:00.000Z", :lower_band=>197.70434666666668, :middle_band=>203.34633666666667, :upper_band=>208.98832666666667},
          {:date_time=>"2018-11-13T00:00:00.000Z", :lower_band=>201.13368, :middle_band=>206.30367, :upper_band=>211.47366000000002},
          {:date_time=>"2018-11-12T00:00:00.000Z", :lower_band=>203.012, :middle_band=>208.2, :upper_band=>213.38799999999998},
          {:date_time=>"2018-11-09T00:00:00.000Z", :lower_band=>203.93166666666667, :middle_band=>209.87366666666668, :upper_band=>215.8156666666667},
          {:date_time=>"2018-11-08T00:00:00.000Z", :lower_band=>204.77, :middle_band=>211.08800000000002, :upper_band=>217.40600000000003},
          {:date_time=>"2018-11-07T00:00:00.000Z", :lower_band=>205.72966666666667, :middle_band=>212.17366666666666, :upper_band=>218.61766666666665},
          {:date_time=>"2018-11-06T00:00:00.000Z", :lower_band=>206.34433333333334, :middle_band=>213.16433333333333, :upper_band=>219.98433333333332},
          {:date_time=>"2018-11-05T00:00:00.000Z", :lower_band=>207.47566666666665, :middle_band=>214.84766666666664, :upper_band=>222.21966666666663},
          {:date_time=>"2018-11-02T00:00:00.000Z", :lower_band=>209.61566666666667, :middle_band=>216.80766666666668, :upper_band=>223.99966666666668},
          {:date_time=>"2018-11-01T00:00:00.000Z", :lower_band=>211.10266666666666, :middle_band=>217.85566666666668, :upper_band=>224.6086666666667},
          {:date_time=>"2018-10-31T00:00:00.000Z", :lower_band=>210.5626666666667, :middle_band=>217.4346666666667, :upper_band=>224.30666666666667},
          {:date_time=>"2018-10-30T00:00:00.000Z", :lower_band=>210.85700000000003, :middle_band=>217.67600000000002, :upper_band=>224.495},
          {:date_time=>"2018-10-29T00:00:00.000Z", :lower_band=>211.63036000000005, :middle_band=>218.48109000000005, :upper_band=>225.33182000000005},
          {:date_time=>"2018-10-26T00:00:00.000Z", :lower_band=>213.14902666666669, :middle_band=>219.0957566666667, :upper_band=>225.0424866666667},
          {:date_time=>"2018-10-25T00:00:00.000Z", :lower_band=>213.71936000000002, :middle_band=>219.51809000000003, :upper_band=>225.31682000000004},
          {:date_time=>"2018-10-24T00:00:00.000Z", :lower_band=>213.0756933333333, :middle_band=>219.1294233333333, :upper_band=>225.1831533333333},
          {:date_time=>"2018-10-23T00:00:00.000Z", :lower_band=>213.17802666666663, :middle_band=>219.29275666666663, :upper_band=>225.40748666666664},
          {:date_time=>"2018-10-22T00:00:00.000Z", :lower_band=>214.05418666666668, :middle_band=>219.8162966666667, :upper_band=>225.5784066666667}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('kc')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Keltner Channel')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period))
      end

      it 'Validates options' do
        valid_options = { period: 22 }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(4)
      end
    end
  end
end
