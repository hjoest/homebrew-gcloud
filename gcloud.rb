require 'formula'

class Gcloud < Formula
  homepage 'https://cloud.google.com/sdk'
  url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-180.0.1-darwin-x86_64.tar.gz'
  version '180.0.1'
  sha256 '33efe06b3a9f5c74aeb7d0048fc4afa634fab5de3c7739dc54aad19c34bb8416'

  depends_on :python

  option "without-completions", "Disable bash/zsh completions"

  def install
    system './install.sh --disable-installation-options --usage-reporting false --path-update false < /dev/null'
    prefix.install Dir['bin']
    prefix.install Dir['help']
    prefix.install Dir['lib']
    prefix.install Dir['platform']
    prefix.install Dir['.install']
    prefix.install 'properties'
    if build.with? "completions"
      bash_completion.install 'completion.bash.inc' => '_gcloud'
      zsh_completion.install 'completion.zsh.inc' => '_gcloud'
    end
  end

  test do
    system "#{bin}/gcloud", "version"
  end

end
