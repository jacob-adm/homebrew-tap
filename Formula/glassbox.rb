class Glassbox < Formula
  desc "Audit what AI agents and other local processes can access"
  homepage "https://github.com/jacob-adm/glassbox"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.5.0/glassbox-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "64e7f1cc55cf79dc0953143818838a526150a82048e5333c2ee4962c1947fddd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.5.0/glassbox-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0b2e061b079faee5fecf616960043097c3d5432ea017cd9c84071b5aebf882cb"
    end
    on_intel do
      url "https://github.com/jacob-adm/glassbox/releases/download/v0.5.0/glassbox-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "403b6419be3011aa274d1a8e1924bc1f58471bb19b3faf2824922e8588645645"
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
