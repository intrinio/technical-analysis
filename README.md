# technical-analysis
A Ruby library for performing technical analysis on stock prices and other data sets.

## Indicators
The following technical indicators are supported:
- Accumulation/Distribution Index (ADI)
- Average Daily Trading Volume (ADTV)
- Average Directional Index (ADX)
- Awesome Oscillator (AO)
- Average True Range (ATR)
- Bollinger Bands (BB)
- Commodity Channel Index (CCI)
- Chaikin Money Flow (CMF)
- Cumulative Return (CR)
- Donchian Channel (DC)
- Daily Log Return (DLR)
- Detrended Price Oscillator (DPO)
- Daily Return (DR)
- Ease of Movement (EOM)
- Force Index (FI)
- Ichimoku Kinko Hyo (ICHIMOKU)
- Keltner Channel (KC)
- Know Sure Thing (KST)
- Moving Average Convergence Divergence (MACD)
- Money Flow Index (MFI)
- Mass Index (MI)
- Negative Volume Index (NVI)
- On-balance Volume (OBV)
- On-balance Volume Mean (OBV_MEAN)
- Relative Strength Index (RSI)
- Simple Moving Average (SMA)
- Stochastic Oscillator (SR)
- Triple Exponential Average (TRIX)
- True Strength Index (TSI)
- Ultimate Oscillator (UO)
- Vortex Indicator (VI)
- Volume-price Trend (VPT)
- Williams %R (WR)

## Install

Add the following line to Gemfile:

```ruby
gem 'technical-analysis'
```

and run `bundle install` from your shell.

To install the gem manually from your shell, run:

```shell
gem install technical-analysis
```

## Usage
There are 2 ways to use this gem for technical analysis.

First, for the sake of these code samples, we'll load some test data from `spec/ta_test_data.csv`. This is the same data used for the unit tests. The data will be an `Array` of `Hashes`.

```ruby
input_data = SpecHelper.get_test_data(:close)
# [
#   { date_time: "2019-01-09T00:00:00.000Z", close: 153.3100 },
#   { date_time: "2019-01-08T00:00:00.000Z", close: 150.7500 },
#   ...
#   { date_time: "2018-10-09T00:00:00.000Z", close: 226.8700 }
# ]
```

### 1) Call the `calculate` method on the specific technical indicator class
```ruby
TechnicalAnalysis::Sma.calculate(input_data, period: 30, price_key: :close)
```

### 2) Call the generic indicator class and pass params to the `calculate` method
The calculate method accepts:
- The indicator `symbol` as a String - `"sma"`
- The data to be used for calculations as an Array of Hashes - `input_data`
- The symbol of the calculation to be performed - `:technicals`
- The options for the indicator as a Hash - `options`
```ruby
options = { period: 30, price_key: :close }
TechnicalAnalysis::Indicator.calculate('sma', input_data, :technicals, options)
```

Each technical indicator has the following methods:
- `indicator_symbol` returns the symbol of the technical indicator as a String.
- `indicator_name` returns the name of the technical indicator as a String.
- `valid_options` returns an Array of keys (as Symbols) for valid options that the technical indicator accepts in its `calculate` method.
- `validate_options` returns true if the options provided are valid or raises a `ValidationError`.
- `min_data_size` returns the minimum number of observations needed (as an Integer) to calculate the technical indicator based on the options provided.
- `calculate` - Each technical indicator returns an Array of values. These values are instances of a class specific to each indicator. It's typically in the format of SymbolValue. For example, Simple Moving Average (SMA) returns an Array of `SmaValue` instances. These classes contain the appropriate data fields for each technical indicator.

For example:
```ruby
TechnicalAnalysis::Sma.indicator_symbol
# "sma"

TechnicalAnalysis::Sma.indicator_name
# "Simple Moving Average"

TechnicalAnalysis::Sma.valid_options
# [:period, :price_key]

options = { period: 30, price_key: :close }
TechnicalAnalysis::Sma.validate_options(options)
# true

options = { period: 30, price_key: :close }
TechnicalAnalysis::Sma.min_data_size(options)
# 30
```

You can also use the generic indicator class. The purpose of this class is to be a sort of master class that will find and call the correct indicator based on the params provided to it.

Here's each example again using the generic indicator class:
```ruby
input_data = SpecHelper.get_test_data(:close)

TechnicalAnalysis::Indicator.calculate('sma', input_data, :indicator_symbol)
# "sma"

TechnicalAnalysis::Indicator.indicator_name('sma', input_data, :indicator_name)
# "Simple Moving Average"

TechnicalAnalysis::Indicator.valid_options('sma', input_data, :valid_options)
# [:period, :price_key]

options = { period: 30, price_key: :close }
TechnicalAnalysis::Indicator.validate_options('sma', input_data, :validate_options, options)
# true

options = { period: 30, price_key: :close }
TechnicalAnalysis::Indicator.min_data_size('sma', input_data, :min_data_size, options)
# 30
```

Or you can use it to find the correct technical indicator class based on symbol:
```ruby
input_data = SpecHelper.get_test_data(:close)

indicator = TechnicalAnalysis::Indicator.find("sma")
# TechnicalAnalysis::Sma

indicator.indicator_symbol
# "sma"

indicator.indicator_name
# "Simple Moving Average"

indicator.calculate(input_data, period: 30, price_key: :close)
```

## Further documentation
This gem is also documented using [Yard](https://yardoc.org/). You can view the [guides](https://yardoc.org/guides/index.html) to help get you started.

## Run Tests
`rspec spec`
