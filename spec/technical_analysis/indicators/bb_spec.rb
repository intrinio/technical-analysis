require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "BB" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Bb

    describe 'Bollinger Bands' do
      it 'Calculates BB (20, 2)' do
        output = indicator.calculate(input_data, period: 20, standard_deviations: 2, price_key: :close)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :lower_band=>141.02036711220762, :middle_band=>157.35499999999996, :upper_band=>173.6896328877923},
          {:date_time=>"2019-01-08T00:00:00.000Z", :lower_band=>141.07714470666247, :middle_band=>158.1695, :upper_band=>175.26185529333753},
          {:date_time=>"2019-01-07T00:00:00.000Z", :lower_band=>141.74551015326722, :middle_band=>159.05649999999997, :upper_band=>176.36748984673272},
          {:date_time=>"2019-01-04T00:00:00.000Z", :lower_band=>142.5717393007821, :middle_band=>160.39600000000002, :upper_band=>178.22026069921793},
          {:date_time=>"2019-01-03T00:00:00.000Z", :lower_band=>143.53956406332316, :middle_band=>161.8175, :upper_band=>180.09543593667684},
          {:date_time=>"2019-01-02T00:00:00.000Z", :lower_band=>145.3682834538487, :middle_band=>163.949, :upper_band=>182.52971654615132},
          {:date_time=>"2018-12-31T00:00:00.000Z", :lower_band=>145.53555575730587, :middle_band=>164.98199999999997, :upper_band=>184.42844424269407},
          {:date_time=>"2018-12-28T00:00:00.000Z", :lower_band=>145.90334076589886, :middle_band=>166.0725, :upper_band=>186.24165923410112},
          {:date_time=>"2018-12-27T00:00:00.000Z", :lower_band=>146.65592111904317, :middle_band=>167.308, :upper_band=>187.96007888095681},
          {:date_time=>"2018-12-26T00:00:00.000Z", :lower_band=>148.0390209273478, :middle_band=>168.2125, :upper_band=>188.38597907265222},
          {:date_time=>"2018-12-24T00:00:00.000Z", :lower_band=>149.41938426834125, :middle_band=>169.08499999999998, :upper_band=>188.7506157316587},
          {:date_time=>"2018-12-21T00:00:00.000Z", :lower_band=>153.6905118237551, :middle_band=>170.35799999999998, :upper_band=>187.02548817624486},
          {:date_time=>"2018-12-20T00:00:00.000Z", :lower_band=>157.58081627897096, :middle_band=>171.6605, :upper_band=>185.74018372102907},
          {:date_time=>"2018-12-19T00:00:00.000Z", :lower_band=>160.2737711222648, :middle_band=>172.66799999999998, :upper_band=>185.06222887773515},
          {:date_time=>"2018-12-18T00:00:00.000Z", :lower_band=>161.48722339827833, :middle_band=>173.91649999999998, :upper_band=>186.34577660172164},
          {:date_time=>"2018-12-17T00:00:00.000Z", :lower_band=>160.6411151779543, :middle_band=>175.28949999999995, :upper_band=>189.9378848220456},
          {:date_time=>"2018-12-14T00:00:00.000Z", :lower_band=>161.3586392867227, :middle_band=>176.66299999999998, :upper_band=>191.96736071327726},
          {:date_time=>"2018-12-13T00:00:00.000Z", :lower_band=>162.73753871102127, :middle_band=>177.72899999999998, :upper_band=>192.7204612889787},
          {:date_time=>"2018-12-12T00:00:00.000Z", :lower_band=>162.83769519003326, :middle_band=>178.79299999999998, :upper_band=>194.7483048099667},
          {:date_time=>"2018-12-11T00:00:00.000Z", :lower_band=>163.37450359253498, :middle_band=>180.04649999999998, :upper_band=>196.71849640746498},
          {:date_time=>"2018-12-10T00:00:00.000Z", :lower_band=>162.797082234342, :middle_band=>181.8385, :upper_band=>200.879917765658},
          {:date_time=>"2018-12-07T00:00:00.000Z", :lower_band=>162.2270311355715, :middle_band=>183.783, :upper_band=>205.33896886442847},
          {:date_time=>"2018-12-06T00:00:00.000Z", :lower_band=>162.58630667652835, :middle_band=>185.856, :upper_band=>209.12569332347164},
          {:date_time=>"2018-12-04T00:00:00.000Z", :lower_band=>163.34919566513827, :middle_band=>187.30850000000004, :upper_band=>211.2678043348618},
          {:date_time=>"2018-12-03T00:00:00.000Z", :lower_band=>164.3311203741903, :middle_band=>188.55350000000004, :upper_band=>212.77587962580978},
          {:date_time=>"2018-11-30T00:00:00.000Z", :lower_band=>164.11704019466114, :middle_band=>189.68650000000005, :upper_band=>215.25595980533896},
          {:date_time=>"2018-11-29T00:00:00.000Z", :lower_band=>163.04822623308377, :middle_band=>191.8685, :upper_band=>220.68877376691626},
          {:date_time=>"2018-11-28T00:00:00.000Z", :lower_band=>163.2435966888823, :middle_band=>193.83400000000003, :upper_band=>224.42440331111777},
          {:date_time=>"2018-11-27T00:00:00.000Z", :lower_band=>164.31484291109825, :middle_band=>195.45200000000006, :upper_band=>226.58915708890186},
          {:date_time=>"2018-11-26T00:00:00.000Z", :lower_band=>167.03813268520582, :middle_band=>197.35200000000003, :upper_band=>227.66586731479424},
          {:date_time=>"2018-11-23T00:00:00.000Z", :lower_band=>169.9836589081704, :middle_band=>199.436, :upper_band=>228.8883410918296},
          {:date_time=>"2018-11-21T00:00:00.000Z", :lower_band=>173.9574856242928, :middle_band=>201.81150000000002, :upper_band=>229.66551437570726},
          {:date_time=>"2018-11-20T00:00:00.000Z", :lower_band=>177.92765761752017, :middle_band=>203.72700000000003, :upper_band=>229.5263423824799},
          {:date_time=>"2018-11-19T00:00:00.000Z", :lower_band=>182.16105406114465, :middle_band=>206.0145, :upper_band=>229.86794593885534},
          {:date_time=>"2018-11-16T00:00:00.000Z", :lower_band=>185.04223870650642, :middle_band=>207.75399999999996, :upper_band=>230.4657612934935},
          {:date_time=>"2018-11-15T00:00:00.000Z", :lower_band=>186.80906188255153, :middle_band=>209.04299999999998, :upper_band=>231.27693811744842},
          {:date_time=>"2018-11-14T00:00:00.000Z", :lower_band=>189.47053333403466, :middle_band=>210.27349999999996, :upper_band=>231.07646666596526},
          {:date_time=>"2018-11-13T00:00:00.000Z", :lower_band=>193.84357681067348, :middle_band=>211.993, :upper_band=>230.1424231893265},
          {:date_time=>"2018-11-12T00:00:00.000Z", :lower_band=>197.38090736241395, :middle_band=>213.48899999999998, :upper_band=>229.597092637586},
          {:date_time=>"2018-11-09T00:00:00.000Z", :lower_band=>201.29218743765117, :middle_band=>214.6485, :upper_band=>228.00481256234886},
          {:date_time=>"2018-11-08T00:00:00.000Z", :lower_band=>202.68427348053234, :middle_band=>215.5305, :upper_band=>228.37672651946764},
          {:date_time=>"2018-11-07T00:00:00.000Z", :lower_band=>203.4002295525166, :middle_band=>215.82850000000002, :upper_band=>228.25677044748343},
          {:date_time=>"2018-11-06T00:00:00.000Z", :lower_band=>204.03232701561498, :middle_band=>216.14900000000003, :upper_band=>228.26567298438508},
          {:date_time=>"2018-11-05T00:00:00.000Z", :lower_band=>205.76564218562143, :middle_band=>217.30400000000003, :upper_band=>228.84235781437863}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('bb')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Bollinger Bands')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period standard_deviations price_key))
      end

      it 'Validates options' do
        valid_options = { period: 22 }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(4)
      end
    end
  end
end
