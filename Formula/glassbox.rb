class Glassbox < Formula
  desc "Security and systems auditing for AI agents and local workloads"
  homepage "https://github.com/jacob-adm/glassbox"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.7.0/glassbox-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "b55118926145330e43b86033a911f0a49df7638746512a7e232de2f18ba6216c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.7.0/glassbox-0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bb7e1cc0cb34230d9d8297036e65d1e37f986b7cbb8cc9bcaabdfe05c1d877c8"
    end
    on_intel do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.7.0/glassbox-0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "40a071138bb1dc22dc017d3bfa20072a71c2b0cd9740f2825b6a0eeb2046e548"
    end
  end

  def install
    bin.install "glassbox"
  end

  test do
    assert_match "usage: glassbox", shell_output("#{bin}/glassbox 2>&1", 2)
    assert_equal "glassbox #{version}", shell_output("#{bin}/glassbox --version").strip
    assert_match "\"findings\":", shell_output("#{bin}/glassbox reach --json --home #{testpath}")
    assert_match "audit-result/1", shell_output("#{bin}/glassbox reach --audit-json --home #{testpath}")
    (testpath/"t.jsonl").write "{\"type\":\"assistant\",\"message\":{\"content\":[]}}\n"
    system bin/"glassbox", "watch", testpath/"t.jsonl", "--once", "--home", testpath
  end
end
