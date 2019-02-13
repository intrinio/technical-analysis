require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "ADX" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)
    indicator = TechnicalAnalysis::Adx

    describe 'Average Directional Index' do
      it 'Calculates ADX (14 day)' do
        output = indicator.calculate(input_data, period: 14)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :adx=>46.70506819299097, :di_neg=>33.86727845364526, :di_pos=>18.75156069669946},
          {:date_time=>"2019-01-08T00:00:00.000Z", :adx=>48.08801057392937, :di_neg=>35.92768510004254, :di_pos=>16.527665969119678},
          {:date_time=>"2019-01-07T00:00:00.000Z", :adx=>48.9421751918944, :di_neg=>37.61461933766297, :di_pos=>13.69466932452777},
          {:date_time=>"2019-01-04T00:00:00.000Z", :adx=>49.12087007192141, :di_neg=>38.89182421063156, :di_pos=>13.835071344467728},
          {:date_time=>"2019-01-03T00:00:00.000Z", :adx=>49.24387794011257, :di_neg=>41.7490776508834, :di_pos=>11.582515799387362},
          {:date_time=>"2019-01-02T00:00:00.000Z", :adx=>48.68078018528377, :di_neg=>34.52657095260412, :di_pos=>13.967710052992748},
          {:date_time=>"2018-12-31T00:00:00.000Z", :adx=>49.16434766454135, :di_neg=>33.6937638052496, :di_pos=>14.788354298902822},
          {:date_time=>"2018-12-28T00:00:00.000Z", :adx=>49.94663571159158, :di_neg=>34.986926565583936, :di_pos=>14.325926339774329},
          {:date_time=>"2018-12-27T00:00:00.000Z", :adx=>50.56577696054131, :di_neg=>36.643305871956294, :di_pos=>12.91725635739372},
          {:date_time=>"2018-12-26T00:00:00.000Z", :adx=>50.77292582473832, :di_neg=>39.7700574645743, :di_pos=>14.019478193733173},
          {:date_time=>"2018-12-24T00:00:00.000Z", :adx=>50.9960092169505, :di_neg=>45.054464306949185, :di_pos=>8.701290502977864},
          {:date_time=>"2018-12-21T00:00:00.000Z", :adx=>49.71673521777664, :di_neg=>44.050625611685426, :di_pos=>9.239278206391834},
          {:date_time=>"2018-12-20T00:00:00.000Z", :adx=>48.516140209610576, :di_neg=>41.59440646182574, :di_pos=>10.25145625667257},
          {:date_time=>"2018-12-19T00:00:00.000Z", :adx=>47.59783553446671, :di_neg=>40.351684937107876, :di_pos=>11.15761353425932},
          {:date_time=>"2018-12-18T00:00:00.000Z", :adx=>46.89941641847421, :di_neg=>37.76941014220763, :di_pos=>12.407839995022263},
          {:date_time=>"2018-12-17T00:00:00.000Z", :adx=>46.61906677289316, :di_neg=>39.53590570860133, :di_pos=>12.988161325358192},
          {:date_time=>"2018-12-14T00:00:00.000Z", :adx=>46.31715176995973, :di_neg=>39.11005826049996, :di_pos=>13.935609588410411},
          {:date_time=>"2018-12-13T00:00:00.000Z", :adx=>46.2293890478109, :di_neg=>36.454819093692386, :di_pos=>14.957814674775397},
          {:date_time=>"2018-12-12T00:00:00.000Z", :adx=>46.56913524205153, :di_neg=>38.04051607484649, :di_pos=>14.793647188928983},
          {:date_time=>"2018-12-11T00:00:00.000Z", :adx=>46.76678475437397, :di_neg=>39.55530357861321, :di_pos=>15.225390789013932},
          {:date_time=>"2018-12-10T00:00:00.000Z", :adx=>46.94782223161259, :di_neg=>41.80590109058211, :di_pos=>14.07235093039379},
          {:date_time=>"2018-12-07T00:00:00.000Z", :adx=>46.74133929346658, :di_neg=>39.25064431094187, :di_pos=>15.206157858128352},
          {:date_time=>"2018-12-06T00:00:00.000Z", :adx=>46.94041765413575, :di_neg=>39.72706616642713, :di_pos=>16.369223356492178},
          {:date_time=>"2018-12-04T00:00:00.000Z", :adx=>47.348231515991635, :di_neg=>35.733971514512405, :di_pos=>17.589281738284058},
          {:date_time=>"2018-12-03T00:00:00.000Z", :adx=>48.37288589247055, :di_neg=>33.43673559814864, :di_pos=>19.42230137516784},
          {:date_time=>"2018-11-30T00:00:00.000Z", :adx=>50.05442754589659, :di_neg=>36.030275362364435, :di_pos=>15.306518521740204},
          {:date_time=>"2018-11-29T00:00:00.000Z", :adx=>50.79951939347192, :di_neg=>36.64084491661032, :di_pos=>15.900754457889013},
          {:date_time=>"2018-11-28T00:00:00.000Z", :adx=>51.67073961575017, :di_neg=>38.80264418160902, :di_pos=>15.0920401856127},
          {:date_time=>"2018-11-27T00:00:00.000Z", :adx=>52.261232848231245, :di_neg=>41.98206441213049, :di_pos=>8.75082128345464},
          {:date_time=>"2018-11-26T00:00:00.000Z", :adx=>51.24268374123445, :di_neg=>43.821787689533835, :di_pos=>9.134296699373357},
          {:date_time=>"2018-11-23T00:00:00.000Z", :adx=>50.14578470293022, :di_neg=>44.05855841207259, :di_pos=>9.605544411876144},
          {:date_time=>"2018-11-21T00:00:00.000Z", :adx=>49.0645966148012, :di_neg=>41.4968168736661, :di_pos=>10.08777861559222},
          {:date_time=>"2018-11-20T00:00:00.000Z", :adx=>48.15507276775653, :di_neg=>43.093658309800155, :di_pos=>10.47596701425822},
          {:date_time=>"2018-11-19T00:00:00.000Z", :adx=>47.17558554786226, :di_neg=>37.739607295468765, :di_pos=>11.632425406517202},
          {:date_time=>"2018-11-16T00:00:00.000Z", :adx=>46.73690113316023, :di_neg=>36.39042671024342, :di_pos=>12.707203247013513},
          {:date_time=>"2018-11-15T00:00:00.000Z", :adx=>46.621508959519026, :di_neg=>38.52265796697687, :di_pos=>10.26180913708443}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('adx')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Average Directional Index')
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
        expect(indicator.min_data_size(options)).to eq(8)
      end
    end
  end
end
