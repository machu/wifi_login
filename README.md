# WifiLogin

An automatically login tool when connected to a public wireless LAN.

公衆無線LANに自動でログインするためのツールです。
現時点では docomo Wi-Fi サービスのみ対応しています。

Mac OS X 用です。バージョン 10.7.4 でテストしています。
docomo Wi-Fi サービスは 802.1X を使うことで自動ログオンが可能ですが、Mac OS X 10.7 (Lion) 以降では標準ツールで 802.1X の設定ができなくなったためこのツールを作りました。


## Installation

gem コマンドを用いてインストールできます。

    $ gem install wifi_login

## Configuration

公衆無線LANにログインするためのIDとパスワードを、pitコマンドで設定してください。

```
$ pit set docomo
---
id: tx2ekeu7-spmode@docomo
password: u563a8t6
```

## Usage

無線LANを有効にして `login` コマンドを実行すると、自動的に公衆無線LANにログインします。

    $ wifi_login login

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
