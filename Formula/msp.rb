class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.17"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.17/msp-v0.0.17-aarch64-apple-darwin.tar.gz"
      sha256 "859c0bcd7bec3b832e595f67a8e65decfa93a4335f4bed0112b06b46b9cd51b0"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.17/msp-v0.0.17-x86_64-apple-darwin.tar.gz"
      sha256 "586f6f6db35c5bb7ad98a78100d87434f98af4980edb573f648c6e504dec9c59"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.17/msp-v0.0.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1b5153767a9d09635fe0e32b3771484f92367ba32ed2bef76868fce16dbe92ab"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.17/msp-v0.0.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "451fb611204421b18614c20d1f74c66cee16748e5f1a9196d0558e739ac45577"
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
