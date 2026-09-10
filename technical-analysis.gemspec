Gem::Specification.new do |spec|
  spec.name          = "technical-analysis"
  spec.version       = "0.2.3"
  spec.authors       = ["Intrinio"]
  spec.email         = ["admin@intrinio.com"]
  spec.description   = %q{A Ruby library for performing technical analysis on stock prices and other data sets.}
  spec.summary       = %q{A Ruby library for performing technical analysis on stock prices and other data sets.}
  spec.homepage      = "https://github.com/intrinio/technical-analysis"
  spec.files         = Dir["{spec,lib}/**/*.*"]
  spec.require_path  = "lib"
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.add_development_dependency "bundler", ">= 2.4"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "csv", ">= 3.2"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9.20"
end
