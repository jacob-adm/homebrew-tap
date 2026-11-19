class Glassbox < Formula
  desc "Audit what AI agents and other local processes can access"
  homepage "https://github.com/jacob-adm/glassbox"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.2.0/glassbox-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "b3871eb152c0be4f5fc34f3a6491727a6ce836df9eef6f32b9ec74428caa851f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.2.0/glassbox-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df4b64f40bfc338571a80db3a3c1759355c7c6de73ee33a3e8d5db2e6b47eaa7"
    end
    on_intel do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.2.0/glassbox-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "11f38b7564549f23d0344cf1298ee792a15fd42cc490e6983be65ee82a070f2c"
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
