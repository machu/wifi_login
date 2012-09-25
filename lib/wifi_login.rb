require "wifi_login/version"
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

  def self.ssid
    status, stdout, stderr = systemu AIRPORT_CMD
    if status.exitstatus != 0
      raise WifiLogin::Error.new("faild to exec #{cmd}")
    end

    ssid_line = stdout.each_line.find {|line| line.match(/^\s+SSID:/) }
    unless ssid_line
      raise WifiLogin::Error.new("not found SSID because may be disable wi-fi")
    end
    ssid_line.chomp.split(': ')[1]
  end
end

