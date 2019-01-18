require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "VI" do
    input_data = SpecHelper.get_test_data(:high, :low, :close)

    describe 'Vortex Indicator' do
      it 'Calculates VI (14 day)' do
        output = TechnicalAnalysis::Vi.calculate(input_data, period: 14)

        expected_output = [
          {:date=>"2018/10/29", :value=> {:negative_vi=>0.9987535631315481, :positive_vi=>0.7711714493088508}},
          {:date=>"2018/10/30", :value=> {:negative_vi=>1.0400453579079016, :positive_vi=>0.8594387814137219}},
          {:date=>"2018/10/31", :value=> {:negative_vi=>0.9136449963918103, :positive_vi=>0.9374983015842824}},
          {:date=>"2018/11/01", :value=> {:negative_vi=>0.9510765744895432, :positive_vi=>0.9155241699342749}},
          {:date=>"2018/11/02", :value=> {:negative_vi=>0.9506581829483907, :positive_vi=>0.7977446639361122}},
          {:date=>"2018/11/05", :value=> {:negative_vi=>1.017756255044391, :positive_vi=>0.73372163931486}},
          {:date=>"2018/11/06", :value=> {:negative_vi=>1.0107777977366625, :positive_vi=>0.7408837794144069}},
          {:date=>"2018/11/07", :value=> {:negative_vi=>0.9456323099415208, :positive_vi=>0.8265716374269011}},
          {:date=>"2018/11/08", :value=> {:negative_vi=>0.9713674816398625, :positive_vi=>0.8198382448638102}},
          {:date=>"2018/11/09", :value=> {:negative_vi=>1.0059420422342082, :positive_vi=>0.7587530852911607}},
          {:date=>"2018/11/12", :value=> {:negative_vi=>1.0186513629842182, :positive_vi=>0.7271341463414641}},
          {:date=>"2018/11/13", :value=> {:negative_vi=>1.053272641569953, :positive_vi=>0.6968210271671884}},
          {:date=>"2018/11/14", :value=> {:negative_vi=>1.0659261208578774, :positive_vi=>0.6477869675714517}},
          {:date=>"2018/11/15", :value=> {:negative_vi=>1.0787197159390678, :positive_vi=>0.6861446786495575}},
          {:date=>"2018/11/16", :value=> {:negative_vi=>1.0499147710692558, :positive_vi=>0.7525644147579889}},
          {:date=>"2018/11/19", :value=> {:negative_vi=>1.018527704309603, :positive_vi=>0.6562081533662589}},
          {:date=>"2018/11/20", :value=> {:negative_vi=>1.1182403853648055, :positive_vi=>0.5634420498548615}},
          {:date=>"2018/11/21", :value=> {:negative_vi=>1.1504168141815485, :positive_vi=>0.5639363354788292}},
          {:date=>"2018/11/23", :value=> {:negative_vi=>1.2070792620527797, :positive_vi=>0.6046320015251558}},
          {:date=>"2018/11/26", :value=> {:negative_vi=>1.1658984366885399, :positive_vi=>0.65775873808705}},
          {:date=>"2018/11/27", :value=> {:negative_vi=>1.1714346511931206, :positive_vi=>0.6287012609627801}},
          {:date=>"2018/11/28", :value=> {:negative_vi=>1.1564601777941095, :positive_vi=>0.6464192792510783}},
          {:date=>"2018/11/29", :value=> {:negative_vi=>1.1373201600900555, :positive_vi=>0.6548920237509929}},
          {:date=>"2018/11/30", :value=> {:negative_vi=>1.1516224812958684, :positive_vi=>0.6987674707967169}},
          {:date=>"2018/12/03", :value=> {:negative_vi=>1.0746012192731307, :positive_vi=>0.8019709726837323}},
          {:date=>"2018/12/04", :value=> {:negative_vi=>1.0423007389465182, :positive_vi=>0.7496451535522679}},
          {:date=>"2018/12/06", :value=> {:negative_vi=>1.0795256042654737, :positive_vi=>0.7516804020221332}},
          {:date=>"2018/12/07", :value=> {:negative_vi=>1.050514334444714, :positive_vi=>0.7172185077490695}},
          {:date=>"2018/12/10", :value=> {:negative_vi=>1.136139122315593, :positive_vi=>0.6334605508870221}},
          {:date=>"2018/12/11", :value=> {:negative_vi=>1.1040510191627, :positive_vi=>0.7505785426583675}},
          {:date=>"2018/12/12", :value=> {:negative_vi=>1.0422719380259118, :positive_vi=>0.8400547615867511}},
          {:date=>"2018/12/13", :value=> {:negative_vi=>1.011590726346824, :positive_vi=>0.8266537121415173}},
          {:date=>"2018/12/14", :value=> {:negative_vi=>0.9867067848168232, :positive_vi=>0.8214508662875287}},
          {:date=>"2018/12/17", :value=> {:negative_vi=>0.974913770577476, :positive_vi=>0.814344133786256}},
          {:date=>"2018/12/18", :value=> {:negative_vi=>0.9773071878279123, :positive_vi=>0.8213523084994758}},
          {:date=>"2018/12/19", :value=> {:negative_vi=>1.067568020631851, :positive_vi=>0.7127001934235981}},
          {:date=>"2018/12/20", :value=> {:negative_vi=>1.1525346959374216, :positive_vi=>0.6361329800656076}},
          {:date=>"2018/12/21", :value=> {:negative_vi=>1.1606095395904847, :positive_vi=>0.5994780447390226}},
          {:date=>"2018/12/24", :value=> {:negative_vi=>1.3088205560235893, :positive_vi=>0.5374882657359492}},
          {:date=>"2018/12/26", :value=> {:negative_vi=>1.2335085243974138, :positive_vi=>0.636331569664903}},
          {:date=>"2018/12/27", :value=> {:negative_vi=>1.1655798789007923, :positive_vi=>0.729855612482534}},
          {:date=>"2018/12/28", :value=> {:negative_vi=>1.1487474529545731, :positive_vi=>0.8037876063766033}},
          {:date=>"2018/12/31", :value=> {:negative_vi=>1.08671679197995, :positive_vi=>0.8781954887218045}},
          {:date=>"2019/01/02", :value=> {:negative_vi=>1.1146552806731134, :positive_vi=>0.8035916112018086}},
          {:date=>"2019/01/03", :value=> {:negative_vi=>1.114675915889877, :positive_vi=>0.7324951224799482}},
          {:date=>"2019/01/04", :value=> {:negative_vi=>1.0760915145470467, :positive_vi=>0.7417758715458455}},
          {:date=>"2019/01/07", :value=> {:negative_vi=>1.0577860164333046, :positive_vi=>0.813115261460082}},
          {:date=>"2019/01/08", :value=> {:negative_vi=>1.0113586362578701, :positive_vi=>0.8600571901821686}},
          {:date=>"2019/01/09", :value=> {:negative_vi=>0.9777149447928525, :positive_vi=>0.8609629970246735}}
        ]

        expect(output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {TechnicalAnalysis::Vi.calculate(input_data, period: input_data.size+1)}.to raise_exception(Validation::ValidationError)
      end
    end
  end
end
