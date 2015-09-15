# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'learn_linter/version'

Gem::Specification.new do |spec|
  spec.name          = "learn_linter"
  spec.version       = LearnLinter::VERSION
  spec.authors       = ["Sophie DeBenedetto"]
  spec.email         = ["sophie.debenedetto@gmail.com"]

  spec.summary       = %q{can lint a directory for valid .learn, license files}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.files = ['lib/learn_linter.rb', 'bin/learn-lint', 'lib/learn_linter/learn_error.rb', 'lib/learn_linter/version.rb', 'lib/learn_linter/license_linter.rb', 'lib/learn_linter/readme_linter.rb', 'lib/learn_linter/valid_license.md', 'lib/learn_linter/yaml_linter.rb', 'lib/learn_linter/contributing_linter.rb', 'lib/learn_linter/valid_contributing.md'] 
  spec.executables << 'learn-lint'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
