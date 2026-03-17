class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.13"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.13/msp-v0.0.13-aarch64-apple-darwin.tar.gz"
      sha256 "8c06e698f004b4f0e962bbeaa39272f7119851b19c3e2409dbd67237487714f5"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.13/msp-v0.0.13-x86_64-apple-darwin.tar.gz"
      sha256 "ef09f62db6ee4c9d09e3b6637ee043043b5c9fcaeed107763497832d504a6427"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.13/msp-v0.0.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a681549680fec9da5d063c38a9567b6916923b72a5eb5584167740ce930999f1"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.13/msp-v0.0.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed3bf05073ca20ac1ee354f21d22fcbbc854a639aa3fc8788425d19cbedf51f4"
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
