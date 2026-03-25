class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.19"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.19/msp-v0.0.19-aarch64-apple-darwin.tar.gz"
      sha256 "59cdf98c993f5d2a937e869b9fc9a9248ec99f35826c12806179f09bdb7d2dfe"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.19/msp-v0.0.19-x86_64-apple-darwin.tar.gz"
      sha256 "a0d1c87001de18ce5b2a30ad9bd3fb8322419168957a366fd6f7972127f1f0e9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.19/msp-v0.0.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a6f0e499cf2dca897b05db2a1a6a1b3648c9b89d4efa6ae0bcbfc11aa33a3b50"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.19/msp-v0.0.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "122d2cc3ae11df1dd2b38468c614eb512bf914cf2d398b409467f903789f2671"
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
