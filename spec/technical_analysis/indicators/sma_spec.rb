require 'technical-analysis'

describe 'Indicators' do
  describe "SMA" do
    input_data = {
      "2018-12-31": 157.74,
      "2018-12-28": 156.23,
      "2018-12-27": 156.15,
      "2018-12-26": 157.17,
      "2018-12-24": 146.83,
      "2018-12-21": 150.73,
      "2018-12-20": 156.83,
      "2018-12-19": 160.89,
      "2018-12-18": 166.07,
      "2018-12-17": 163.94,
      "2018-12-14": 165.48,
      "2018-12-13": 170.95,
      "2018-12-12": 169.1,
      "2018-12-11": 168.63,
      "2018-12-10": 169.6
    }

    describe 'Simple Moving Average' do
      it 'Calculates SMA (5 day)' do
        output = TechnicalAnalysis::Sma.calculate(input_data, period: 5)

        expected_output = {
          :"2018-12-14"=>168.752,
          :"2018-12-17"=>167.61999999999998,
          :"2018-12-18"=>167.108,
          :"2018-12-19"=>165.46599999999998,
          :"2018-12-20"=>162.642,
          :"2018-12-21"=>159.692,
          :"2018-12-24"=>156.27,
          :"2018-12-26"=>154.49,
          :"2018-12-27"=>153.54199999999997,
          :"2018-12-28"=>153.422,
          :"2018-12-31"=>154.824
        }

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        calc = Calculate.new
        expect {TechnicalAnalysis::Sma.calculate(input_data, period: 30)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
