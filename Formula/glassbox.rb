class Glassbox < Formula
  desc "Audit what AI agents and other local processes can access"
  homepage "https://github.com/jacob-adm/glassbox"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.3.0/glassbox-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "15992f0b35e8b1e6e017c3136666eaec7a2751c0482da044654a02a2bb4b7c52"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.3.0/glassbox-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "09b9b170af1569ef571840b3af40e9dbde20168c13335a9207f9b185fbd72f61"
    end
    on_intel do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.3.0/glassbox-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "51579ef59cdda6bf5b3a0ec27fdd4b9c0dd0a3c86f9c038698b21c5df66c52b3"
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
