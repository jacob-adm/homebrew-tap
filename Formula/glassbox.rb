class Glassbox < Formula
  desc "Audit what AI agents and other local processes can access"
  homepage "https://github.com/jacob-adm/glassbox"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.4.0/glassbox-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "6e09767bb04cd39d77a48666d9a1a4d91f689dbf48118ddb690918b4a6c885b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.4.0/glassbox-0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1df1b862824414fa7ba315cab263d1ae4a965e7d12c0c10f0021146f50c21ddd"
    end
    on_intel do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.4.0/glassbox-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7944b552967798e6f071d70d19d6e39ae5e6cadb7cbada270d204e974058796f"
    end
  end

  def install
    bin.install "glassbox"
  end

  test do
    assert_match "usage: glassbox", shell_output("#{bin}/glassbox 2>&1", 2)
    assert_match "\"findings\":", shell_output("#{bin}/glassbox reach --json --home #{testpath}")
    (testpath/"t.jsonl").write "{\"type\":\"assistant\",\"message\":{\"content\":[]}}\n"
    system bin/"glassbox", "watch", testpath/"t.jsonl", "--once", "--home", testpath
  end
end
