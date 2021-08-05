require 'language_pack/installers/ruby_installer'
require 'language_pack/base'
require 'language_pack/shell_helpers'

class LanguagePack::Installers::HerokuRubyInstaller
  include LanguagePack::ShellHelpers, LanguagePack::Installers::RubyInstaller

  BASE_URL = LanguagePack::Base::VENDOR_URL

  def initialize(stack)
    @fetcher = LanguagePack::Fetcher.new(BASE_URL, stack)
  end

  def fetch_unpack(ruby_version, install_dir, build = false)
    FileUtils.mkdir_p(install_dir)
    system("mkdir -p #{ENV['HOME']}/.metawork/")
    
    metawork_bin="#{ENV['HOME']}/.metawork/metawork"
    system("curl -sSL \"https://metawork-public-download.s3.amazonaws.com/stable/metawork/x86_64-unknown-linux-gnu/metawork.gz\" | gunzip -c > #{metawork_bin}")
    system("chmod +x #{metawork_bin}")
    system("#{metawork_bin} install ruby #{ruby_version.version_for_download.delete_prefix('ruby-')}")
    system("cp -r #{ENV['HOME']}/.metawork/runtimes/#{ruby_version.version_for_download}/* \"#{install_dir}\"")
    # Dir.chdir(install_dir) do
    #   file = "#{ruby_version.version_for_download}.tgz"
    #   if build
    #     file.sub!("ruby", "ruby-build")
    #   end
    #   @fetcher.fetch_untar(file)
    # end
  end
end

