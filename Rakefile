require 'rubygems'
require 'rake/gempackagetask'

gemspec = Gem::Specification.new do |gem|
  gem.name = "streamingjsonparser"
  gem.summary = %Q{This gem accepts chunked JSON input and returns nicely segmented JSON.}
  gem.description = %Q{This gem accepts chunked JSON input and returns nicely segmented JSON. Streaming JSON is commonly sent as chunked encoded HTTP.}
  gem.version = File.read('VERSION').strip
  gem.email = "josh@statewidesoftware.com"
  gem.homepage = "http://statewidesoftware.com"
  gem.authors = ["Joshua Harding"]
  gem.add_development_dependency "rspec", "~>2.0.0"

  files = FileList["**/*"]
  files.exclude /\.DS_Store/
  files.exclude /\#/
  files.exclude /~/
  files.exclude /\.swp/
  files.exclude '**/._*'
  files.exclude '**/*.orig'
  files.exclude '**/*.rej'
  files.exclude /^pkg/
  files.exclude '**/*.o'
  files.exclude '**/*.bundle'
  files.exclude '**/*.a'
  files.exclude '**/*.so'
  files.exclude 'streamingjsonparser.gemspec'

  gem.files = files.to_a

  gem.test_files = FileList["spec/**/*.rb"].to_a
end

# Gem packaging tasks
Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

task :gem => :gemspec

desc %{Build the gemspec file.}
task :gemspec do
  gemspec.validate
  File.open("#{gemspec.name}.gemspec", 'w'){|f| f.write gemspec.to_ruby }
end

task :default => :gemspec
