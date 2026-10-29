class Zar < Formula
  desc "Random-access archiver built on zstd"
  homepage "https://github.com/kevpatt/zar"
  url "https://github.com/kevpatt/zar/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "767395f6e116802635711136c1e29abc22789285274be8b9eead30b01135572b"
  license "BSD-3-Clause"
  head "https://github.com/kevpatt/zar.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "xxhash"
  depends_on "zstd"

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DZAR_BUILD_TESTS=OFF",
                    "-DZAR_USE_SYSTEM_XXHASH=ON",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"proj/hello.txt").write "hello\n"
    (testpath/"proj/sub/data.bin").write "x" * 100_000
    system bin/"zar", "proj"
    assert_path_exists testpath/"proj.zar"

    assert_match "hello.txt", shell_output("#{bin}/unzar -l proj.zar")
    refute_path_exists testpath/"out" # a listing writes nothing

    system bin/"unzar", "-C", "out", "proj.zar"
    assert_equal "hello\n", (testpath/"out/proj/hello.txt").read
    assert_equal "x" * 100_000, (testpath/"out/proj/sub/data.bin").read
    assert_match version.to_s, shell_output("#{bin}/zar --version")
  end
end
