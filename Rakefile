require 'bundler/setup'
require 'rspec/core/rake_task'
require 'fileutils'

DISTRIBUTIONS = [
  { rb_platform: 'x86_64-darwin', tuple: %w(darwin amd64) },
  { rb_platform: 'arm64-darwin',  tuple: %w(darwin arm64) },
  { rb_platform: 'x86-linux',     tuple: %w(linux 386) },
  { rb_platform: 'x86_64-linux',  tuple: %w(linux amd64) },
  { rb_platform: 'arm-linux',     tuple: %w(linux arm) },
  { rb_platform: 'arm64-linux',   tuple: %w(linux arm64) },
  { rb_platform: 'aarch64-linux', tuple: %w(linux arm64) },
  { rb_platform: 'ppc64le-linux', tuple: %w(linux ppc64le) },
  { rb_platform: 's390x-linux',   tuple: %w(linux s390x) },
  { rb_platform: 'x86-mswin64',   tuple: %w(windows 386), ext: '.exe' },
  { rb_platform: 'x64-mswin64',   tuple: %w(windows amd64), ext: '.exe' }
]

task :build do
  require 'rubygems/package'
  require 'open-uri'
  require 'kubectl-rb/version'

  FileUtils.mkdir_p('pkg')

  DISTRIBUTIONS.each do |distro|
    FileUtils.rm_rf('vendor')
    FileUtils.mkdir('vendor')

    tuple = distro[:tuple].join('/')
    exe = "kubectl#{distro[:ext]}"
    url = "https://dl.k8s.io/release/v#{KubectlRb::KUBECTL_VERSION}/bin/#{tuple}/#{exe}"
    vendored_exe = File.join('vendor', exe)
    File.write(vendored_exe, URI.open(url).read)

    # user rwx, group rx, world rx
    File.chmod(0755, vendored_exe)

    gemspec = eval(File.read('kubectl-rb.gemspec'))
    gemspec.platform = distro[:rb_platform]
    package = Gem::Package.build(gemspec)
    FileUtils.mv(package, 'pkg')
  end
end

task :publish do
  require 'kubectl-rb/version'

  Dir.glob(File.join('pkg', "kubectl-rb-#{KubectlRb::VERSION}-*.gem")).each do |pkg|
    puts "Publishing #{pkg}"
    system("gem push -k rubygems #{pkg}")
  end
end

task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end
