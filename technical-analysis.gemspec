Gem::Specification.new do |spec|
  spec.name          = "technical-analysis"
  spec.version       = "0.2.2"
  spec.authors       = ["Intrinio"]
  spec.email         = ["admin@intrinio.com"]
  spec.description   = %q{A Ruby library for performing technical analysis on stock prices and other data sets.}
  spec.summary       = %q{A Ruby library for performing technical analysis on stock prices and other data sets.}
  spec.homepage      = "https://github.com/intrinio/technical-analysis"
  spec.files         = Dir["{spec,lib}/**/*.*"]
  spec.require_path  = "lib"
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9.20"
end
