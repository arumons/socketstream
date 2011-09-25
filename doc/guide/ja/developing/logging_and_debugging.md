### ロギングとデバッグ

クライアントとサーバーサイドのロギングは __development__ と __staging__ モードではデフォルトでオン、__production__ モードではオフになっています。
ロギングの設定はそれぞれ `SS.config.client.log.level` と `SS.config.log.level` の値にて変更できます。
ロギングのレベルには 0 から 4 までの 5段階を設定できます。数字が大きいほど冗長なロギングをします。デフォルトのレベルは 3 です。

#### Node.js デバッガの使用

なんらかの `socketstream` コマンドの前に `debug` をつけることでデバッガを利用することができます。

    socketstream debug start

ヒント：デバッガはシングルプロセスモードの時に一番良く動作します。ZeroMQ がインストール済みなら、下記のコマンドにて SocketStream がシングルプロセスで起動するようにしてください。

    socketstream debug single

素晴らしい Node Inspectort をインストールすることもできます：https://github.com/dannycoates/node-inspector

#### 例外処理

サーバーサイドイベントのおかげで、アプリコードで発生した例外は簡単に処理できます。

``` coffee-script
SS.events.on 'application:exception', (error) ->
  console.log "例外が発生しました: #{error.message}"
  # email を開発者に送る
```
