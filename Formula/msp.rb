class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.18"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.18/msp-v0.0.18-aarch64-apple-darwin.tar.gz"
      sha256 "efe19148fa8f5a7d488f127e5a6022c22b0d48e52038b3f313006b04a0a103a8"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.18/msp-v0.0.18-x86_64-apple-darwin.tar.gz"
      sha256 "1e12d2507df8dcddb139a48770c70e157d91442bedc59d0b458f7852288db3c6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.18/msp-v0.0.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c5adca90b10198c4360335be16d1d4653f984872b7ac5f0842e4b83565c07a82"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.18/msp-v0.0.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f4130576ed851381b0e6cac8d4e604b47a4e8cce151c6fea13db6c0237eeb99d"
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
