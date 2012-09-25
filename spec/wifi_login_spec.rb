# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'wifi_login'

describe WifiLogin do
  AIRPORT_CMD = '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I'

  describe '.providers' do
    subject { WifiLogin.providers }

    it do
      subject.should be_kind_of Hash
    end
  end

  describe '.ssid' do
    subject { WifiLogin.ssid }

    context 'when enable wifi' do
      before do
        status = double(:status, :exitstatus => 0)
        stdout = <<-EOL
     agrCtlRSSI: -70
     agrExtRSSI: 0
    agrCtlNoise: -96
    agrExtNoise: 0
          state: running
        op mode: station 
     lastTxRate: 48
        maxRate: 54
lastAssocStatus: 0
    802.11 auth: open
      link auth: none
          BSSID: 00:00:00:00:00:00
           SSID: docomo
            MCS: -1
        channel: 6
        EOL
        WifiLogin.stub!(:systemu).with(AIRPORT_CMD).and_return([status, stdout, ''])
      end

      it "取得したSSIDを返すこと" do
        subject.should eq 'docomo'
      end
    end

    context 'when disable wifi' do
      before do
        status = double(:status, :exitstatus => 0)
        stdout = "AirPort: Off\n"
        WifiLogin.stub!(:systemu).with(AIRPORT_CMD).and_return([status, stdout, ''])
      end

      it "例外を返すこと" do
				expect { subject }.to raise_error
      end
    end
  end
end
