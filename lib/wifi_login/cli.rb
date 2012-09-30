require 'thor'
require 'wifi_login'

module WifiLogin
  class CLI < Thor
    include Thor::Actions

    desc "install", "Install trigger to your Mac OS X System (launchd)."
    def install
      raise WifiLogin::Error.new("not implemented")
    end

    desc "uninstall", "Uninstall trigger."
    def uninstall
      raise WifiLogin::Error.new("not implemented")
    end

    desc "ssid", "Show current SSID"
    def ssid
      puts "current SSID: #{WifiLogin.ssid}"
    end

    desc "login", "Login public wi-fi access point."
    def login
      success = WifiLogin.login
      puts 'login success' if success
    end

    desc "version", "Prints the bundler's version information"
    def version
      puts "wifi_login #{WifiLogin::VERSION}"
    end
    map %w(-v --version) => :version

  end
end
