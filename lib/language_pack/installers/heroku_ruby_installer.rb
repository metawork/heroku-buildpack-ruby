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
    system("cp -r \"$HOME\"/.metawork/runtimes/ruby-3.0.2/* \"#{install_dir}\"")
    # Dir.chdir(install_dir) do
    #   file = "#{ruby_version.version_for_download}.tgz"
    #   if build
    #     file.sub!("ruby", "ruby-build")
    #   end
    #   @fetcher.fetch_untar(file)
    # end
  end
end

