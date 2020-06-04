require 'bundler/setup'
require 'rspec/core/rake_task'
require 'fileutils'

DISTRIBUTIONS = [
  { rb_platform: 'i386-darwin',   filename: 'darwin-386' },
  { rb_platform: 'x86_64-darwin', filename: 'darwin-amd64' },
  { rb_platform: 'i386-linux',    filename: 'linux-386' },
  { rb_platform: 'x86_64-linux',  filename: 'linux-amd64' },
  { rb_platform: 'arm-linux',     filename: 'linux-arm' },
  { rb_platform: 'arm64-linux',   filename: 'linux-arm64' },
  { rb_platform: 'ppc64le-linux', filename: 'linux-ppc64le' },
  { rb_platform: 's390x-linux',   filename: 'linux-s390x' },
  { rb_platform: 'i386-mswin64',  filename: 'windows-386' },
  { rb_platform: 'x64-mswin64',   filename: 'windows-amd64' }
]

task :build do
  require 'rubygems/package'
  require 'open-uri'
  require 'kubectl-rb/version'

  FileUtils.mkdir_p('pkg')

  DISTRIBUTIONS.each do |distro|
    FileUtils.rm_rf('vendor')
    FileUtils.mkdir('vendor')

    url = "https://dl.k8s.io/v#{KubectlRb::KUBECTL_VERSION}/kubernetes-client-#{distro[:filename]}.tar.gz"
    archive = 'kubectl.tar.gz'
    File.write(archive, open(url).read)
    FileUtils.mkdir('kubectl')
    system("tar -C kubectl -xzvf #{archive}")
    FileUtils.rm(archive)

    Dir.glob(File.join(*%w(kubectl kubernetes client bin), 'kubectl*')).each do |exe|
      system("chmod +x #{exe}")
      FileUtils.cp(exe, 'vendor')
    end

    FileUtils.rm_rf('kubectl')

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
    STDOUT.write("Enter OTP code: ")
    otp = STDIN.gets.strip
    system("gem push -k rubygems --otp #{otp} #{pkg}")
  end
end

task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end
