# WifiLogin

An automatically login tool when connected to a public wireless LAN.

公衆無線LANに自動でログインするためのツールです。
現時点では docomo Wi-Fi サービスのみ対応しています。

Mac OS X 用です。バージョン 10.7.4 でテストしています。
docomo Wi-Fi サービスは 802.1X を使うことで自動ログオンが可能ですが、Mac OS X 10.7 (Lion) 以降では標準ツールで 802.1X の設定ができなくなったためこのツールを作りました。


## Installation

gem コマンドを用いてインストールできます。

    $ gem install wifi_login

rbenv を使っているのであれば、忘れずに `rehash` も実行してください。

    $ rbenv rehash

## Configuration

公衆無線LANに接続したときに自動的にこのスクリプトを起動するように設定します。
`wifi\_login install` コマンドを実行してください。

```
$ wifi_login install
      create  /Users/machu/Library/Logs/jp.machu.wifi_login
      create  /Users/machu/Library/LaunchAgents/jp.machu.wifi_login.plist
         run  launchctl load /Users/machu/Library/LaunchAgents/jp.machu.wifi_login.plist from "."

Complete install. Please run `pit set docomo` to set your ID/Password.
Example
--
id: your-id-spmode@docomo
password: your-password
```

公衆無線LANにログインするためのIDとパスワードを、pitコマンドで設定してください。

```
$ pit set docomo
---
id: your-id-spmode@docomo
password: your-password
```

## Usage

無線LANを有効にして `login` コマンドを実行すると、自動的に公衆無線LANにログインします。

    $ wifi_login login

前述の `install` コマンドを実行していれば、 `login` コマンドを手動で実行する必要はありません。

## Uninstall

このスクリプトを無効にするには、 `uninstall` コマンドを実行してください。 `install` コマンドで登録した自動起動設定を削除します。

```
$ wifi_login uninstall
         run  launchctl unload /Users/machu/Library/LaunchAgents/jp.machu.wifi_login.plist from "."
      remove  /Users/machu/Library/LaunchAgents/jp.machu.wifi_login.plist
```

## TODO

 * launchdを用いた公衆無線LANへの自動接続
 * Growlによるログオン完了通知
 * WISPr対応

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
