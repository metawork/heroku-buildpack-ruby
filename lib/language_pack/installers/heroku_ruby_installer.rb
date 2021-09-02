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
    version = ruby_version.version_for_download.delete_prefix('ruby-')
    url = "https://metawork-public-download.s3.us-west-2.amazonaws.com/latest/ruby/#{version}/x86_64-unknown-linux-gnu/ruby-#{version}.tgz"
    file = "#{install_dir}/ruby-#{version}.tgz"
    system("curl -sSL \"#{url}\" > #{file}")
    system("tar xzf #{file} --strip-components 1 -C #{install_dir}")
    # Dir.chdir(install_dir) do
    #   file = "#{ruby_version.version_for_download}.tgz"
    #   if build
    #     file.sub!("ruby", "ruby-build")
    #   end
    #   @fetcher.fetch_untar(file)
    # end
  end
end

