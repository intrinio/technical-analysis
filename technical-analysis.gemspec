Gem::Specification.new do |spec|
  spec.name          = "technical-analysis"
  spec.version       = "1.0.0"
  spec.authors       = ["Intrinio"]
  spec.email         = ["admin@intrinio.com"]
  spec.description   = %q{Intrinio Technical Analysis}
  spec.summary       = %q{Intrinio Technical Analysis}
  spec.homepage      = "https://github.com/intrinio/technical-analysis"
  spec.files         = Dir["{spec,lib}/**/*.*"]
  spec.require_path  = "lib"
  spec.metadata['allowed_push_host'] = 'https://intrinio.com'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9.6"
end