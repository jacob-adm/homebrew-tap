class Glassbox < Formula
  desc "Security and systems auditing for AI agents and local workloads"
  homepage "https://github.com/jacob-adm/glassbox"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.6.0/glassbox-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "08d6cd86f7f7e22df68dfb9dd8f2240cef98d7085438c392a216e2a73c354037"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.6.0/glassbox-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "39c0a27d8b5645a436d72f563263ce6b03e688eb5d378fcdd53b511cdeb6e12c"
    end
    on_intel do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.6.0/glassbox-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1c562bb9d7aa9e7ac135617e558675c58d2f0f9a8b6fc64e015d1a97b0787ef1"
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
