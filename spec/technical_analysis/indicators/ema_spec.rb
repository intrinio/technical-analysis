require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "EMA" do
    input_data = SpecHelper.get_test_data(:close)
    indicator = TechnicalAnalysis::Ema

    describe 'Exponential Moving Average' do
      it 'Calculates EMA (5 day)' do
        output = indicator.calculate(input_data, period: 5, price_key: :close)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :ema=>151.1937160522574},
          {:date_time=>"2019-01-08T00:00:00.000Z", :ema=>150.1355740783861},
          {:date_time=>"2019-01-07T00:00:00.000Z", :ema=>149.82836111757913},
          {:date_time=>"2019-01-04T00:00:00.000Z", :ema=>150.77754167636868},
          {:date_time=>"2019-01-03T00:00:00.000Z", :ema=>152.03631251455303},
          {:date_time=>"2019-01-02T00:00:00.000Z", :ema=>156.95946877182956},
          {:date_time=>"2018-12-31T00:00:00.000Z", :ema=>156.47920315774434},
          {:date_time=>"2018-12-28T00:00:00.000Z", :ema=>155.8488047366165},
          {:date_time=>"2018-12-27T00:00:00.000Z", :ema=>155.65820710492477},
          {:date_time=>"2018-12-26T00:00:00.000Z", :ema=>155.41231065738714},
          {:date_time=>"2018-12-24T00:00:00.000Z", :ema=>154.53346598608073},
          {:date_time=>"2018-12-21T00:00:00.000Z", :ema=>158.3851989791211},
          {:date_time=>"2018-12-20T00:00:00.000Z", :ema=>162.21279846868165},
          {:date_time=>"2018-12-19T00:00:00.000Z", :ema=>164.90419770302248},
          {:date_time=>"2018-12-18T00:00:00.000Z", :ema=>166.91129655453372},
          {:date_time=>"2018-12-17T00:00:00.000Z", :ema=>167.3319448318006},
          {:date_time=>"2018-12-14T00:00:00.000Z", :ema=>169.02791724770088},
          {:date_time=>"2018-12-13T00:00:00.000Z", :ema=>170.80187587155132},
          {:date_time=>"2018-12-12T00:00:00.000Z", :ema=>170.72781380732698},
          {:date_time=>"2018-12-11T00:00:00.000Z", :ema=>171.54172071099046},
          {:date_time=>"2018-12-10T00:00:00.000Z", :ema=>172.99758106648568},
          {:date_time=>"2018-12-07T00:00:00.000Z", :ema=>174.69637159972854},
          {:date_time=>"2018-12-06T00:00:00.000Z", :ema=>177.7995573995928},
          {:date_time=>"2018-12-04T00:00:00.000Z", :ema=>179.33933609938921},
          {:date_time=>"2018-12-03T00:00:00.000Z", :ema=>180.6640041490838},
          {:date_time=>"2018-11-30T00:00:00.000Z", :ema=>178.58600622362573},
          {:date_time=>"2018-11-29T00:00:00.000Z", :ema=>178.5890093354386},
          {:date_time=>"2018-11-28T00:00:00.000Z", :ema=>178.10851400315786},
          {:date_time=>"2018-11-27T00:00:00.000Z", :ema=>176.69277100473678},
          {:date_time=>"2018-11-26T00:00:00.000Z", :ema=>177.91915650710516},
          {:date_time=>"2018-11-23T00:00:00.000Z", :ema=>179.56873476065772},
          {:date_time=>"2018-11-21T00:00:00.000Z", :ema=>183.20810214098657},
          {:date_time=>"2018-11-20T00:00:00.000Z", :ema=>186.42215321147984},
          {:date_time=>"2018-11-19T00:00:00.000Z", :ema=>191.14322981721975},
          {:date_time=>"2018-11-16T00:00:00.000Z", :ema=>193.7848447258296},
          {:date_time=>"2018-11-15T00:00:00.000Z", :ema=>193.9122670887444},
          {:date_time=>"2018-11-14T00:00:00.000Z", :ema=>195.1634006331166},
          {:date_time=>"2018-11-13T00:00:00.000Z", :ema=>199.34510094967487},
          {:date_time=>"2018-11-12T00:00:00.000Z", :ema=>202.90265142451233},
          {:date_time=>"2018-11-09T00:00:00.000Z", :ema=>207.26897713676848},
          {:date_time=>"2018-11-08T00:00:00.000Z", :ema=>208.66846570515273},
          {:date_time=>"2018-11-07T00:00:00.000Z", :ema=>208.75769855772907},
          {:date_time=>"2018-11-06T00:00:00.000Z", :ema=>208.16154783659363},
          {:date_time=>"2018-11-05T00:00:00.000Z", :ema=>210.35732175489045},
          {:date_time=>"2018-11-02T00:00:00.000Z", :ema=>214.7409826323357},
          {:date_time=>"2018-11-01T00:00:00.000Z", :ema=>218.37147394850354},
          {:date_time=>"2018-10-31T00:00:00.000Z", :ema=>216.44721092275532},
          {:date_time=>"2018-10-30T00:00:00.000Z", :ema=>215.24081638413296},
          {:date_time=>"2018-10-29T00:00:00.000Z", :ema=>216.21122457619944},
          {:date_time=>"2018-10-26T00:00:00.000Z", :ema=>218.19683686429914},
          {:date_time=>"2018-10-25T00:00:00.000Z", :ema=>219.1452552964487},
          {:date_time=>"2018-10-24T00:00:00.000Z", :ema=>218.81788294467307},
          {:date_time=>"2018-10-23T00:00:00.000Z", :ema=>220.6818244170096},
          {:date_time=>"2018-10-22T00:00:00.000Z", :ema=>219.65773662551442},
          {:date_time=>"2018-10-19T00:00:00.000Z", :ema=>219.1616049382716},
          {:date_time=>"2018-10-18T00:00:00.000Z", :ema=>219.0874074074074},
          {:date_time=>"2018-10-17T00:00:00.000Z", :ema=>220.6211111111111},
          {:date_time=>"2018-10-16T00:00:00.000Z", :ema=>220.33666666666667},
          {:date_time=>"2018-10-15T00:00:00.000Z", :ema=>219.43}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+1, price_key: :close)}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('ema')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Exponential Moving Average')
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
        expect { indicator.validate_options(invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(4)
      end
    end
  end
end
