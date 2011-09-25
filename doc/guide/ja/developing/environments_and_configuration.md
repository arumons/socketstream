### 環境設定

他のフレームワークと同様に、SocketStream は複数の環境におけるコードの実行をサポートしています。

SocketStream はデフォルトでは __development__ モードにで起動します。このモードではすべてのリクエストとレスポンスはターミナルに表示され、サーバサイドで発生したあらゆる例外はブラウザのコンソールに表示され、すべてのクライアントアセットはデバッグ用にそのままコンパイルされます。

__development__モードの他に __staging__ と __production__ の二つのモードを利用できます。それぞれモードごとの用途にあった設定で SocketStream をロードします。

プリセット変数の上書きや追加は、設定ファイルを書き換えることで行えます。アプリケーション全体に適用される設定ファイルは /config/app.coffee で、それぞれの環境に適用される設定ファイルは /config/enviroments/<SS_ENV>.coffee です（例: /config/environments/development.coffee）。なお、<SS_ENV>.coffee は app.coffee の設定を上書きします。

__development__モード以外の環境で SocketStream を立ち上げるには SS_ENV環境変数を使います。

    SS_ENV=staging socketstream start
    
追加できる環境の数に制限はありません。サーバー、もしくはクライアント側コンソール上で `SS.env` とタイプすることでどの環境で動作しているのかを容易に確認できます。

すべての設定可能な環境変数は近日公開予定のサイトにてお知らせします。現在は SocketStream コンソール上で `SS.config` とタイプすることですべての設定可能な環境変数を確認できます（また config ファイルにて設定の上書きができます）。


#### コンフィグ設定の方法

README を読んでいると、コンフィグ変数を変更しているような下記の表記をたびたび目にするでしょう。

    SS.config.limiter.enabled = true

この場合、設定ファイルで次のように書くことで環境変数の値を変更できます。

``` coffee-script
exports.config =
  limiter:
    enabled: true
```

#### Socket.IO の設定
 
Socket.IO 0.8 の設定は /app/config.coffee にて configure() 関数を定義することで行うことができます。
 
例:
 
``` coffee-script
  socketio:
    configure: (io) ->
      io.set 'log level', 5
      io.set 'transports', ['websocket', 'flashsocket', 'xhr-polling']
