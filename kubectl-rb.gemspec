$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'kubectl-rb/version'

Gem::Specification.new do |s|
  s.name     = 'kubectl-rb'
  s.version  = ::KubectlRb::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/getkuby/kubectl-rb'
  s.license  = 'Apache-2.0'

  s.description = s.summary = 'Kubectl distributed as a Rubygem.'

  s.platform = Gem::Platform::RUBY

  s.require_path = 'lib'
  s.files = Dir['{lib,spec,vendor}/**/*', 'Gemfile', 'LICENSE', 'CHANGELOG.md', 'README.md', 'Rakefile', 'kubectl-rb.gemspec']
end
