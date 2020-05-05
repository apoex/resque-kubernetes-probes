require_relative 'lib/resque/kubernetes/probes/version'

Gem::Specification.new do |spec|
  spec.name          = "resque-kubernetes-probes"
  spec.version       = Resque::Kubernetes::Probes::VERSION
  spec.authors       = ["Micke Lisinge"]
  spec.email         = ["hi@micke.me"]

  spec.summary       = %q{Kubernetes probes for resque}
  spec.description   = %q{Kubernetes probes for resque}
  spec.homepage      = "https://github.com/apoex/resque-kubernetes-probes"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/apoex/resque-kubernetes-probes"
  spec.metadata["changelog_uri"] = "https://github.com/apoex/resque-kubernetes-probes"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
