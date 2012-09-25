# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + './../../spec_helper')
require 'wifi_login/providers/docomo'

describe WifiLogin::Providers::Docomo do
  describe '#login?' do
    before do
      ssid = 'docomo'
      @provider = WifiLogin.providers[ssid]
    end

    context "when successful" do
      let(:credential) { { :id => 'test', :pass => 'password' } }
      subject { @provider.login(credential) }

      it "ログイン成功を返す" do
        subject.should be true
      end
    end

    context "when unsuccessful" do
    end
  end
end
