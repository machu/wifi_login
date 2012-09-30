require 'thor'

module WifiLogin
  class CLI < Thor
    include Thor::Actions

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
