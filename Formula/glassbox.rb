class Glassbox < Formula
  desc "Security and systems auditing for AI agents and local workloads"
  homepage "https://github.com/jacob-adm/glassbox"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.5.1/glassbox-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "07b9931562b51c5241371e2546755bdb8e6c71cae5217c3a307cde17f9c432e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.5.1/glassbox-0.5.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b2a7db62f2de349ec9164f7ae1b4dea68d19e70e2f0b23be903653deb07ade77"
    end
    on_intel do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.5.1/glassbox-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "786de44f4f6c18556bad68aa87fb790c0a56eb9c0cbfd3fd013686512c8b4025"
    end
  end

  def install
    bin.install "glassbox"
  end

  test do
    assert_match "usage: glassbox", shell_output("#{bin}/glassbox 2>&1", 2)
    assert_equal "glassbox #{version}", shell_output("#{bin}/glassbox --version").strip
    assert_match "\"findings\":", shell_output("#{bin}/glassbox reach --json --home #{testpath}")
    (testpath/"t.jsonl").write "{\"type\":\"assistant\",\"message\":{\"content\":[]}}\n"
    system bin/"glassbox", "watch", testpath/"t.jsonl", "--once", "--home", testpath
  end
end
