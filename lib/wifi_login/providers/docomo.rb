require 'wifi_login'
require 'mechanize'

module WifiLogin
  module Providers
    class Docomo
      WifiLogin.providers['docomo'] = self

      def login(id, password)
        url = 'https://wlan.m-zone.jp/wlan/portal.jsp'
        agent = Mechanize.new
        page = agent.get(url)
        if status(page) == :success_auth
          return true
        end
        form = page.form
        form.user = id
        form.password = password
        page = agent.submit(form)
        if status(page) != :success_auth
          raise WifiLogin::Error.new('Login failure. (incorrect id/password?)')
        end
        true
      end

      def status(page)
        case page.title
        when 'Login'
          :before_auth
        when 'Top page'
          :success_auth
        when /^Login error/
          :fail_auth
        else
          raise WifiLogin::Error.new("cannot parse page: #{page.title}")
        end
      end
    end
  end
end
