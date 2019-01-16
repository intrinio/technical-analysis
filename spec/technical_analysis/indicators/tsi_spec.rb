require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "TSI" do
    input_data = SpecHelper.get_test_data(:close)

    describe 'True Strength Index' do
      it 'Calculates True Strength Index' do
        output = TechnicalAnalysis::Tsi.calculate(input_data, low_period: 13, high_period: 25, price_key: :close)

        expected_output = [
          {:date=>"2018/11/30", :value=>-32.212798598181024},
          {:date=>"2018/12/03", :value=>-29.524570107700253},
          {:date=>"2018/12/04", :value=>-28.752945178257534},
          {:date=>"2018/12/06", :value=>-28.4796578607378},
          {:date=>"2018/12/07", :value=>-29.357900955250976},
          {:date=>"2018/12/10", :value=>-29.704744795960114},
          {:date=>"2018/12/11", :value=>-30.15935663446155},
          {:date=>"2018/12/12", :value=>-30.375476807689427},
          {:date=>"2018/12/13", :value=>-29.91401235092671},
          {:date=>"2018/12/14", :value=>-30.569488217596724},
          {:date=>"2018/12/17", :value=>-31.403055885745307},
          {:date=>"2018/12/18", :value=>-31.30170501401141},
          {:date=>"2018/12/19", :value=>-32.23640227177938},
          {:date=>"2018/12/20", :value=>-33.78946079860395},
          {:date=>"2018/12/21", :value=>-36.202827241203856},
          {:date=>"2018/12/24", :value=>-38.83883734905748},
          {:date=>"2018/12/26", :value=>-36.802531445786066},
          {:date=>"2018/12/27", :value=>-35.41195667338275},
          {:date=>"2018/12/28", :value=>-34.28080772951784},
          {:date=>"2018/12/31", :value=>-32.785927300024994},
          {:date=>"2019/01/02", :value=>-31.495178028566524},
          {:date=>"2019/01/03", :value=>-33.579027007940994},
          {:date=>"2019/01/04", :value=>-32.874679857827935},
          {:date=>"2019/01/07", :value=>-32.39480993311267},
          {:date=>"2019/01/08", :value=>-30.97413963420104},
          {:date=>"2019/01/09", :value=>-28.91017661103889}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        low_period = 13
        high_period = 25
        size_limit = low_period + high_period - 1
        input_data = input_data.first(size_limit)

        expect {TechnicalAnalysis::Tsi.calculate(input_data, low_period: low_period, high_period: high_period, price_key: :close)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
