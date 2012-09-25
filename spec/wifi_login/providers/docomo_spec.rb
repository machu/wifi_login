# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + './../../spec_helper')
require 'wifi_login/providers/docomo'

describe WifiLogin::Providers::Docomo do
  before do
    @provider = WifiLogin::Providers::Docomo.new
  end

  describe '#login' do
    context "when successful" do
      let(:id) { 'id' }
      let(:password) { 'password' }
      subject { @provider.login(id, password) }

      it "ログイン成功を返す" do
        subject.should be true
      end
    end

    context "when unsuccessful" do
    end
  end
end
