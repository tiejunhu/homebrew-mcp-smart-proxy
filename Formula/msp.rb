class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.12/msp-v0.0.12-aarch64-apple-darwin.tar.gz"
      sha256 "b7ac12cccb10cf8e5e7e7e7f048aa9c1d6cac7bd959f82aba7dba7823dcce377"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.12/msp-v0.0.12-x86_64-apple-darwin.tar.gz"
      sha256 "72313c6564372cef1a73de5eaf7cd7ad72222d3cdd5197e4e7ba68bee417be92"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.12/msp-v0.0.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "79240e36baeb49bac46d83aa01e01206fbf42bd0d8cbfa45301c30d12278a053"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.12/msp-v0.0.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b288320ef68d6060e721c4ebd7cd0c9b560a9e52eb444127bba8d2bebc6625e7"
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
