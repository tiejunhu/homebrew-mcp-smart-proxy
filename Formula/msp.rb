class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.15"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.15/msp-v0.0.15-aarch64-apple-darwin.tar.gz"
      sha256 "7a8e1b8665751717bff3ffe5418e75bdbf9d1f47f4155d9a70f64e932f17dea5"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.15/msp-v0.0.15-x86_64-apple-darwin.tar.gz"
      sha256 "0d4bd69c32c95a8131e1bc224a82d3ece006eb05b0d9c39a8208894128e43162"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.15/msp-v0.0.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "027b2e9d47c97300291232e6477a4a7dc84a04ce477153b9e155bb45c07d7057"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.15/msp-v0.0.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c612b7ade87bfbdcba06add2c0968b18da65183864bf02b28420d35cbf0ac96e"
    end
  end

  def install
    binary = Dir["msp", "*/msp", "mcp-smart-proxy", "*/mcp-smart-proxy"].first
    raise "msp binary not found in archive" unless binary

    bin.install binary => "msp"

    metafiles_dir = Dir["README.md", "LICENSE*", "COPYING*", "*/README.md", "*/LICENSE*", "*/COPYING*"].empty? ? nil : Dir["*", "."].find do |entry|
      next false unless File.directory?(entry)

      Dir[File.join(entry, "README.md"), File.join(entry, "LICENSE*"), File.join(entry, "COPYING*")].any?
    end

    prefix.install_metafiles(metafiles_dir || ".")
  end

  test do
    assert_match "A smart MCP proxy", shell_output("#{bin}/msp --help")
  end
end
