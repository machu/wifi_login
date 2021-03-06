# coding: utf-8
require 'thor'
require 'wifi_login'

module WifiLogin
  class CLI < Thor
    include Thor::Actions

    LAUNCH_AGENT_DIR = "#{ENV['HOME']}/Library/LaunchAgents"
    LAUNCH_AGENT_FILE = "#{LAUNCH_AGENT_DIR}/jp.machu.wifi_login.plist"
    LOG_DIR = "#{ENV['HOME']}/Library/Logs/jp.machu.wifi_login"

    def self.source_root
      File.dirname(__FILE__)
    end

    desc "install", "Install trigger to your Mac OS X System (launchd)."
    def install
      empty_directory LOG_DIR
      if WifiLogin.in_rbenv?
        template "templates/jp.machu.wifi_login.plist.rbenv.tt", "#{LAUNCH_AGENT_FILE}"
      else
        template "templates/jp.machu.wifi_login.plist.tt", "#{LAUNCH_AGENT_FILE}"
      end
      run "launchctl load #{LAUNCH_AGENT_FILE}"
      say
      say "Complete install. Please run `pit set docomo` to set your ID/Password.", Thor::Shell::Color::GREEN
      say "Example"
      say "--"
      say "id: your-id-spmode@docomo"
      say "password: your-password"
    end

    desc "uninstall", "Uninstall trigger."
    def uninstall
      run "launchctl unload #{LAUNCH_AGENT_FILE}"
      return unless File.exist?(LAUNCH_AGENT_FILE)
      remove_file LAUNCH_AGENT_FILE
    end

    desc "ssid", "Show current SSID"
    def ssid
      say "current SSID: #{WifiLogin.ssid}"
    end

    desc "login", "Login public wi-fi access point."
    def login
      success = WifiLogin.login
      say 'Login success!', Thor::Shell::Color::GREEN if success
    end

    desc "version", "Prints the bundler's version information"
    def version
      say "wifi_login #{WifiLogin::VERSION}"
    end
    map %w(-v --version) => :version

  end
end
