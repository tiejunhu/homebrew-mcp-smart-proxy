class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.16/msp-v0.0.16-aarch64-apple-darwin.tar.gz"
      sha256 "e28862be5bcd5e0d950a6874698df6ec8df780909023cfda7fc107488d72098a"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.16/msp-v0.0.16-x86_64-apple-darwin.tar.gz"
      sha256 "0de859e918ed7914f16e0481259c206dc9b6db85a89e4a5f7fd9286a7aa41551"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.16/msp-v0.0.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "82cfc10a9e5b4a530c212e7c85bf3b34253c9b7366111d5859b6a7c56adab3a3"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.16/msp-v0.0.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b3f610d463a090f511bf38ff2c934d8a5398f7f07ec9bbeff9af0335869c0d82"
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
