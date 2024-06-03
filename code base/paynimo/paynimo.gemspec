$:.push File.expand_path("../lib", __FILE__)
require 'paynimo/version'

Gem::Specification.new do |s|
  s.name = "paynimo"
  s.summary = "Paynimo Gateway Ruby Client Library"
  s.description = "Ruby library for integrating with the Paynimo Gateway"
  s.version = Paynimo::Version::VERSION
  s.license = "MIT"
  s.author = "Paynimo" 
  s.email = ""
  s.homepage = ""
  s.rubyforge_project = "paynimo"
  s.has_rdoc = false
  s.files = Dir.glob ["README.rdoc", "LICENSE", "lib/**/*.{rb,crt}", "spec/**/*", "*.gemspec"]
  s.add_dependency "builder", ">= 3.1.4"
  s.add_dependency "encryptor", ">=1.3.0"
  s.add_dependency "savon", ">= 2.11.1"  
end
