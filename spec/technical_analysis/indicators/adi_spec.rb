require 'technical-analysis'

describe 'Indicators' do
  describe "ADI" do
    input_data = {
      "2018-12-31": {open: 157.74, high: 158.74, low: 154.74, close: 158.14, volume: 1000},
      "2018-12-28": {open: 156.23, high: 156.23, low: 156.23, close: 156.23, volume: 1000},
      "2018-12-27": {open: 156.15, high: 156.15, low: 156.15, close: 156.15, volume: 1000},
      "2018-12-26": {open: 157.17, high: 157.17, low: 157.17, close: 157.17, volume: 1000},
      "2018-12-24": {open: 146.83, high: 146.83, low: 146.83, close: 146.83, volume: 1000},
      "2018-12-21": {open: 150.73, high: 150.73, low: 150.73, close: 150.73, volume: 1000},
      "2018-12-20": {open: 156.83, high: 156.83, low: 156.83, close: 156.83, volume: 1000},
      "2018-12-19": {open: 160.89, high: 160.89, low: 160.89, close: 160.89, volume: 1000},
      "2018-12-18": {open: 166.07, high: 166.07, low: 166.07, close: 166.07, volume: 1000},
      "2018-12-17": {open: 163.94, high: 163.94, low: 163.94, close: 163.94, volume: 1000},
      "2018-12-14": {open: 165.48, high: 165.48, low: 165.48, close: 165.48, volume: 1000},
      "2018-12-13": {open: 170.95, high: 170.95, low: 170.95, close: 170.95, volume: 1000},
      "2018-12-12": {open: 169.10, high: 169.10, low: 169.10, close: 169.10, volume: 1000},
      "2018-12-11": {open: 168.63, high: 168.63, low: 168.63, close: 168.63, volume: 1000},
      "2018-12-10": {open: 169.60, high: 169.60, low: 169.60, close: 169.60, volume: 1000}
    }

    describe 'Accumulation/Distribution Index' do
      it 'Calculates ADI' do
        output = TechnicalAnalysis::Adi.calculate(input_data)

        puts output

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
          :"2018-12-31"=>154.823
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
