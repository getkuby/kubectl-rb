module KubectlRb
  def self.executable
    @executable ||= begin
      pattern = File.expand_path(File.join('..', 'vendor', 'kubectl*'), __dir__)
      Dir.glob(pattern).first
    end
  end
end
