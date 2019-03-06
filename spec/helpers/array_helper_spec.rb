require 'technical-analysis'
require 'spec_helper'

describe 'ArrayHelper' do
  array_of_numbers = [1, 3, 5, 7, 9].freeze

  it 'Calculates sum' do
    sum = TechnicalAnalysis::ArrayHelper.sum(array_of_numbers)
    expect(sum).to eq(25)
  end

  it 'Calculates mean' do
    mean = TechnicalAnalysis::ArrayHelper.mean(array_of_numbers)
    expect(mean).to eq(5)
  end

  it 'Calculates average' do
    average = TechnicalAnalysis::ArrayHelper.average(array_of_numbers)
    expect(average).to eq(5)
  end

  it 'Calculates sample_variance' do
    sample_variance = TechnicalAnalysis::ArrayHelper.sample_variance(array_of_numbers)
    expect(sample_variance).to eq(10.0)
  end

  it 'Calculates standard_deviation' do
    standard_deviation = TechnicalAnalysis::ArrayHelper.standard_deviation(array_of_numbers)
    expect(standard_deviation).to eq(3.1622776601683795)
  end
end
