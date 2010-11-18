# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{streamingjsonparser}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Harding"]
  s.date = %q{2010-11-17}
  s.description = %q{This gem accepts chunked JSON input and returns nicely segmented JSON. Streaming JSON is commonly sent as chunked encoded HTTP.}
  s.email = %q{josh@statewidesoftware.com}
  s.files = ["spec/streaming_json_parser_spec.rb", "VERSION", "Rakefile", "lib/streaming_json_parser.rb"]
  s.homepage = %q{http://statewidesoftware.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{This gem accepts chunked JSON input and returns nicely segmented JSON.}
  s.test_files = ["spec/streaming_json_parser_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.0.0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.0.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.0.0"])
  end
end
