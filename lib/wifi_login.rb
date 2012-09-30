require "wifi_login/version"
require "pit"
require "systemu"

module WifiLogin
  class Error < StandardError; end

  AIRPORT_CMD = '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I'

  module Providers
    autoload :Docomo, 'wifi_login/providers/docomo'
  end

  def self.providers
    @@providers ||= {}
  end

  def self.login
    ssid = self.ssid
    puts "detected SSID: #{ssid}"
    provider = provider(ssid)
    id, password = credential(ssid)
    begin
      provider(ssid).login(id, password)
    rescue SocketError => e
      puts e.message
      retry_count ||= 0
      raise if (retry_count += 1) > 6
      sleep 10
      retry
    end
  end

  def self.provider(ssid)
    provider_name = WifiLogin::Providers.constants.find {|provider|
      provider.downcase.to_s == ssid.downcase
    }
    unless provider_name
      raise WifiLogin::Error.new("provider is not found for SSID: #{ssid}")
    end
    WifiLogin::Providers.const_get(provider_name).new
  end

  def self.credential(ssid)
    pit = Pit.get(ssid)
    id = pit['id']
    password = pit['password']
    unless (id && password)
      raise WifiLogin::Error.new("credential is not found. please run `pit set #{ssid}`.") 
    end
    [id, password]
  end

  def self.ssid
    status, stdout, stderr = systemu AIRPORT_CMD
    if status.exitstatus != 0
      raise WifiLogin::Error.new("faild to exec #{cmd}")
    end

    ssid_line = stdout.each_line.find {|line| line.match(/^\s+SSID:/) }
    unless ssid_line
      raise WifiLogin::Error.new("not found SSID (disable wi-fi?)")
    end
    ssid_line.chomp.split(': ')[1]
  end

  def self.in_rbenv?
    ENV.has_key?('RBENV_ROOT')
  end
end

