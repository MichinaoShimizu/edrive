
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edrive/version'

Gem::Specification.new do |spec|
  spec.name          = 'edrive'
  spec.version       = Edrive::VERSION
  spec.authors       = ['MichinaoShimizu']
  spec.email         = ['shimizu.michinao@gmail.com']

  spec.summary       = 'Generic Event Dispatcher.
  Provide simple event dispatcher mechanism for all of ruby products.

  '
  spec.description = 'Generic Event Dispatcher.
  Provide simple event dispatcher mechanism for all of ruby products.

  '
  spec.homepage      = 'https://github.com/MichinaoShimizu/edrive'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that
  # have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
