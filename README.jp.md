![SocketStream!](https://github.com/socketstream/socketstream/raw/master/new_project/public/images/logo.png)


Latest release: 0.2.2   ([view changelog](https://github.com/socketstream/socketstream/blob/master/HISTORY.md))

Twitter: [@socketstream](http://twitter.com/#!/socketstream)
Google Group: http://groups.google.com/group/socketstream
IRC channel: [#socketstream](http://webchat.freenode.net/?channels=socketstream) on freenode

[バージョン0.2についてのアナウンスメント](https://github.com/socketstream/socketstream/blob/master/doc/annoucements/0.2.md)

### イントロダクション

SocketStrem は [Single-page Application](http://en.wikipedia.org/wiki/Single-page_application) パラダイムにあわせて開発された新しいフルスタックWebフレームワークであり、分散ホスティングプラットフォームです。
websocket や、インメモリデータベース（Redis）、クライアントサイドでのレンダリングを取り入れることで驚くほどのレスポンスを実現しています。

まだ開発段階ではありますが、リアルタイムWebアプリを構築するための機能の多くは使えるようになっており、比較的安定しています。
まだ存在しない機能（特に、サーバーサイドモデルを構築するエレガントな方法、外部認証機能、組み込みのテストフレームワーク、フロントエンドスケーリング）は現在フルタイムで開発が進められているため、数ヶ月中にリリースされる見込みです。開発プロセスのスピードアップのため、あらゆる貢献が取り入れられています。

最近の開発状況や考えは [@socketstream](http://twitter.com/#!/socketstream) よりご覧になれます。近日中に Webサイトを公開します。

### 特徴

#### 全般

* websocket（または予備として [Socket.IO 0.8](http://socket.io/) ）を使った双方向通信を行います。遅くて複雑なAJAXとはサヨナラです！
* 全てのコードは [CoffeeScript](http://jashkenas.github.com/coffee-script/) もしくは JavaScript にて記述します。好きな方を選んでください
* クライアント／サーバー間でコードを簡単に共有できます。ビジネスロジックやモデルの検証に最適です
* セッションの検索、pub/sub、オンラインユーザの一覧表示など、即時性が要求されるデータの扱いには [Redis](http://www.redis.io/) を使います
* 簡単にスケーラブルな pub/sub が利用可能です。プライベートチャンネルも利用可能です
* 組み込みのユーザモデル - モジュール化された内部認証システムを備えています（Facebook Connect といった外部への認証システムは近日リリース予定です）
* 対話的コンソール - `socketstream console` とタイプするだけで、サーバーサイドと共有コード内のメソッドが呼び出せます
* API Trees - 巨大なコードベースの名前空間を、シンプルで一貫したものにできます
* [Connect](http://senchalabs.github.com/connect/) - サードパーティや自身のミドルウェアを組み込むことができます。これらは柔軟性とスピードを最大限にするため、最初に実行されます
* サーバーサイドイベント - クライアントの初期接続／切断時、サーバーサイドにてカスタムコードが実行されます
* MITライセンスです

#### クライアントサイド

* ネイティブ websocket を使う Chrome と Safari、__そして今は Firefox 6__ にて問題なく動きます。
* Socket.IO が websocket の代わりに働くおかげで、IE や 古いバージョンの Firefox でも動作します。
* 3G回線上の iPad や iPhone の Mobile Safari（iOS 4.2 以上）でも問題なく動きます
* 統合されたアセットマネージャー。全てのクライアントサイドアセットは自動的にパッケージングかつ[ミニファイ](https://github.com/mishoo/UglifyJS)されます
* バンドルされた jQuery - jQuery は特に必須ではありません。Zepto や他のライブラリでも問題ないでしょう
* バンドルされた [jQuery templates](http://api.jquery.com/category/plugins/templates/) - Rails の partials のように動作します
* [Underscore.js](http://documentcloud.github.com/underscore/) といったクライアントライブラリを簡単に追加できます
* 初期HTMLレイアウトは [Jade](http://jade-lang.com/) かプレーンHTML にて記述します
* Stylus を CSS生成に使えます（プレーンなCSSも問題なく使えます）

#### 分散ホスティング

* 自動的なHTTPリダイレクトによって、すぐにHTTPSが使えるようになっています
* フロントエンドとバックエンドの分散アーキテクチャは軽量な RPC 抽象化レイヤによって分離が行われます
* インストールが必要なCライブラリを必要とせず、シングルプロセスによる高速な立ち上げを可能にします（Cloud9 IDE にとって理想的です）
* スケールアップが必要になった場合、ZeroMQ を使うことで、簡単にマルチCPU や サーバーに処理を分散させることができます
* 複数のバックエンドサーバーに対してCPUをフルに使うタスクを分散させた場合、線形にスケールします（`socketstream benchmark` で試すことができます）
* フロントエンドサーバーは Redis や 他のデータベースから完全に分離することができます。フロントエンドは `socketstream router`コマンドで起動したプロセスのみと通信する必要があります
* 内部で使われるRPCレイヤは将来に備えて、転送とシリアライゼーションのフォーマットを容易に追加できるようになっています

#### オプショナルなモジュール（必要な場合のみロード）

* HTTP/HTTPS API - すべてのサーバサイドコードは自動で高速なリクエストベースのAPIからアクセスできるようになります
* オンラインユーザ - ユーザのログイン状態を自動的にトラッキングします
* Plug ソケット - ZeroMQ を使うことによって、外部サーバーや、レガシーなアプリと高速な通信を行います。20 以上の言語がサポートされています
* Rate 制限 - DDOS 攻撃を防ぐために初歩的な Rate 制限をかけます

### どのように動作するの？

ユーザの初回アクセス時、SocketStream は全ての静的 HTML、CSS、クライアントサイドコードを自動的に圧縮しミニファイして送信します。

その後、全てのデータはシリアライズされた JSONオブジェクトとして websocket トンネル（もしくは Socket.IO のフォールバック機構）経由でやりとりされます。
トンネルはクライアントが接続した直後に生成されます。また、切断しても自動的に再生成されます。

つまり、コネクションレイテンシ、HTTPヘッダによるオーバーヘッド、扱いにくいAJAX呼び出しが無いのです。
SocketStream は、正真正銘の双方向で非同期な'ストリーミング'通信をクライアント／サーバ間で可能にします。

### 何がつくれるの？

SocketStream が得意なのはリアルタイムデータ（チャット、株式取引、位置のモニタリング、分析など）を扱うモダンなアプリケーションです。
HTML5 によるリアルタイムなゲームを作るプラットフォームとしてもふさわしいでしょう。
ブログ等、SEO のためにユニークな URL を必要とするコンテンツリッチなサイトには、今のところ向きません。

### チュートリアル

[SocketStream でつくるリアルタイムな CoffeeScript Webアプリケーション](http://addyosmani.com/blog/building-real-time-coffeescript-web-applications-with-socketstream/) by [Addy Osmani](http://addyosmani.com)


### サンプルアプリ集

これらのアプリは今のところ小さなものですが、コードを読むことで SocketStream の学習に役立つでしょう。

[SocketChat](https://github.com/addyosmani/socketchat) - シンプルなグループチャット

[Dashboard](https://github.com/paulbjensen/socketstream_dashboard_example) - 設定可能なウィジェットを持つリアルタイムダッシュボード

[SocketRacer](https://github.com/alz/socketracer) - マルチプレイヤーレーシングゲーム


### サンプルその１：Baxic RPC

SocketStream を使いこなす鍵になるのが `SS` グローバル変数です。これはサーバ／クライアントサイドのどこからでも呼び出せます。

例えば、数を二乗するシンプルなサーバーサイドの関数を書いてみましょう。このコードを /app/server/app.coffee ファイルに追加してください。


``` coffee-script
exports.actions =

  square: (number, cb) ->
    cb(number * number)
```

この関数をブラウザから呼び出すために、下記のコードを /app/client/app.coffee ファイルに追加してください。

``` coffee-script
exports.square = (number) ->
  SS.server.app.square number, (response) ->
    console.log "#{number} の二乗は #{response}"
```

サーバーを再起動してページをリフレッシュした後、次のコードをブラウザのコンソールから入力してください。

``` coffee-script
SS.client.app.square(25)
```

以下のように出力されたと思います。

    25 の二乗は 625

注意深い人なら `SS.client.app.square(25)` が実際には 'undefined' を返していることに気がつくでしょう。この動作は正常です。注目すべきはリクエストが処理された後にサーバーから非同期に送られるレスポンスです。

サーバーサイドで作成したメソッドはオプションで提供される HTTP API（デフォルトでは有効になっています） を使って下記の URL で呼び出すこともできます。

``` coffee-script
/api/app/square?25                        # ヒント: .json を使うとファイルに出力できます
```

サーバーサイドのコンソール(`socketstream console` とタイプ)や、ブラウザのコンソール、他のサーバーサイドのファイルから呼び出すこともできます。

``` coffee-script
SS.server.app.square(25, function(x){ console.log(x) })
```

注釈: ブラウザから `SS.server` メソッドを呼び出した場合、`console.log` コールバックが自動的に挿入されます。

`SS` 変数が jQuery の '$' に似ていることに気がつかれたかもしれません。'SS' は SocketStream API にアクセスする主要な方法です。クライアント／サーバ間で API が同じになるように私たちはベストをつくしています。

さあ、もっと深い内容に進みましょう。準備はいいですか？　それでは HTML5 Geolocation を使ったリバースジオコーディング（Reverse geocoding）を見てみましょう。


### サンプルその２: リバースジオコーディング

サーバーコードとして /app/server/geocode.coffee を作成して下記のコードをペーストしてください。

``` coffee-script
exports.actions =

  lookup: (coords_from_browser, cb) ->
    host = 'maps.googleapis.com'
    r = coords_from_browser.coords
    http = require('http')
    google = http.createClient(80, host)
    google.on 'error', (e) -> console.error "#{host} に接続できませんでした"
    request = google.request 'GET', "/maps/api/geocode/json?sensor=true&latlng=#{r.latitude},#{r.longitude}"
    request.end()
    request.on 'error', (e) -> console.error "#{host} からのレスポンスのパースに失敗しました"
    request.on 'response', (response) => parseResponse(response, cb)

parseResponse = (response, cb) ->  # 注釈: プライベートメソッドは exports.actions の外側に書かれている
  output = ''
  response.setEncoding('utf8')
  response.on 'data', (chunk) -> output += chunk
  response.on 'end', ->
    j = JSON.parse(output)
    result = j.results[0]
    cb(result)
```

現在地を取得してその住所を出力するために次のコードを /app/client/app.coffee に追加してください。

``` coffee-script
# 注釈: SS.client.app.init() メソッドは、ソケットが作成されてセッションが利用可能になった時に、自動的に一度だけ呼び出されます。
exports.init = ->
  SS.client.geocode.determineLocation()
```

次にクライアントサイドの名前空間（下記セクション参照）を試すため /app/client/geocode.coffee ファイルを作成し、以下のコードを書いてください。

``` coffee-script
exports.determineLocation = ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(success, error)
  else
    alert 'なんということでしょう。お使いのブラウザでは Geolocation がサポートされていません。実装されるそのときまでお待ちください'

# プライベートな関数

success = (coords_from_browser) ->
  SS.server.geocode.lookup coords_from_browser, (response) ->
    console.log response
    alert 'あなたの現在地: ' + response.formatted_address

error = (err) ->
  console.error err
  alert 'おっと。現在地を見つけられませんでした。オンラインになってますか？'
```

コードを実行すると現在地が表示されます（WiFi 環境下なら、より正確な位置になります）。もちろん実際にはクライアントへのコールバックの処理を実行中に起こりうる様々なエラーに対応する必要があるでしょう。

おまけ: 再実行はどうすればできるでしょうか？　`SS.client.geocode.determineLocation()` とブラウザのコンソールでタイプするだけです。すべての `exportされた` クライアントサイドの関数はこの方法で呼び出せます。


### サンプルその３: Pub/Sub

チャットアプリやユーザへのプッシュ通知を作るにはどうすればよいでしょうか？

まず始めにクライアント側で 'newMessage' イベントをリッスンしましょう。

``` coffee-script
exports.init = ->
  SS.events.on('newMessage', (message) -> alert(message))
```

通知を行いたいユーザの ID を知っていると仮定します。サーバーサイドで次のように書くことでユーザにメッセージを通知できます。

``` coffee-script
exports.actions =

  testMessage: (user_id) ->
    SS.publish.user(user_id, 'newMessage', '超カッコイイ！')
```

ね、簡単でしょう？　魅力はこれだけではありません。ユーザがどのサーバーに接続しているかを気にする必要はありません。SocketStream サーバーは Redis の共通インスタンスを見ているのでメッセージは常に正しいサーバへ送られます。

全ユーザへブロードキャストする方法や、プライベートチャンネルを実装する方法を知りたいですか？　それなら後述の 'Pub/Sub をもっと知る' セクションを読んでください。


### 動作環境

[Node 0.4.X](http://nodejs.org/#download) 注釈: [Connect](http://senchalabs.github.com/connect/) が 0.5/0.6 をサポート次第、SocketStream もそれらのバージョンで動作するようになるでしょう。

[NPM 1.0](http://npmjs.org/) （Node Package Manager）か、それ以降のバージョン

[Redis 2.2](http://redis.io/) か、それ以降のバージョン


### SocketStrem を動かそう

SocketStream を実際に動かしてみましょう。SocketStream は NPMパッケージとして公開されています。インストールは以下のコマンドをタイプするだけです。

    sudo npm install socketstream -g

新規の SocketStream プロジェクトを作成するには次のようにタイプしてください。

    socketstream new <name_of_your_project>


アプリを起動するために、ローカルで Redis が動いていることを確認してください。次に `cd` コマンドにて作成したディレクトリに入り、下記コマンドをタイプします。

    socketstream start

正常に起動すると SocketStream のバナーが表示されるはずです。下記アドレスを開いて作成したアプリを見てみましょう。

   http://localhost:3000


## 索引

すべてのドキュメントは /doc/guide/ja の中にあります。

#### SocketStream アプリを開発する。

* [ディレクトリ構造](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/project_directory_overview.md)
* [名前空間 - API ツリーを使うコードをどのように組み立てるか](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/namespacing.md)
* [Pub/Sub をもっと知る - ブロードキャスティングとプライベートチャンネル](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/pub_sub.md)
* [サーバーサイドコード - in /app/server](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/server_code.md)
* [共有コード - in /app/shared](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/shared_code.md)
* [ユーザーと認証](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/users_and_authentication.md)
* [環境と設定](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/environments_and_configuration.md)
* [@session オブジェクト - セッションデータの取得／設定](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/the_session_object.md)
* [@request オブジェクト - HTTP POST データの取得とその他について](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/the_request_object.md)
* [サーバーサイドイベント](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/server-side_events.md)
* [回線切断時のハンドリング](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/handling_disconnects.md)
* [Javascript ヘルパー](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/javascript_helpers.md)
* [Redis への接続](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/connecting_to_redis.md)
* [MongoDB や 他DB への接続](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/connecting_to_databases.md)
* [カスタム HTTP ミドルウェア](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/custom_http_middleware.md)
* [ロギング と デバッグ](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/developing/logging_and_debugging.md)

#### オプショナルモジュール

下記モジュールは有効にした時にのみロードされます。

* [HTTP API - 高速な JSON API 経由による /app/server メソッドへのアクセス](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/optional_modules/http_api.md)
* [Users Online - オンライン状態のユーザー一覧を取得](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/optional_modules/users_online.md)
* [Plug Sockets - ZeroMQ を使っての外部サービスとの接続](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/optional_modules/plug_sockets.md)
* [Browser Check - 非互換のブラウザへの対応](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/optional_modules/browser_check.md)
* [Rate Limiter - DDOS 攻撃への初歩的な対応](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/optional_modules/rate_limiter.md)


#### デプロイ

* [ZeroMQ によるスケールアップ](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/deploying/scaling.md)
* [HTTPS / SSL の利用](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/deploying/https_ssl.md)
* [セキュリティ](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/deploying/security.md)

#### その他

* [FAQs](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/faqs.md)
* [内部 RPC のスペック](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/rpc_spec.md)
* [貢献](https://github.com/socketstream/socketstream/blob/master/doc/guide/en/contributing.md)

***

### テスト

安定した機能に対して我々はテストを書き始めました。カバーしているのは分割されたプロジェクトの内でも少数の部分だけですが、いずれにせよテストは始まっています。
テストツールとして Jasmine を選択しましたが、どのようにテストファイルを構成し、specsをどこで起動するかを決める必要があります。
（websocketのテストはブラウザから行う方がはるかに簡単だからです）一度方針が固まれば、Github にてテストが行えるようになるでしょう。

### 既知の問題

* lib/client に追加した新しいファイルを反映させるには、サーバを再起動して /lib/client 内のファイルのどれかを変更しなければなりません。近日修正する予定です。
* jQuery の $('body') への操作（例: $('body').hide）を Firefox4 でやると flashsocket コネクションが切断されます。私たちがこの奇妙なバグの原因が分かるまで、$('body') の呼び出しは避けたほうがよいでしょう。


### コアチーム

* Owen Barnes (socketstream & owenb)
* Paul Jensen (paulbjensen)
* Alan Milford (alz)
* Addy Osmani (addyosmani)


### クレジット

Guillermo Rauch（Socket.IO）、TJ Holowaychuk（Stylus, Jade）、Jeremy Ashkenas（CoffeeScript）、Mihai Bazon（UglifyJS）、Isaac Schlueter（NPM）、Salvatore Sanfilippo（Redis）、Justin Tulloss（Node ZeroMQ bindings）そして SocketStream をよりよいものにしてくれた沢山の方々の素晴らしい活動に感謝します。違うアプローチで取り組むことにインスピレーションをくれた Ryan Dahl（node.js の開発者）には特別な感謝を送ります。


### 謝辞

SocketStream の開発は AOL に支援されています。


### ライセンス

SocketStream は MITライセンスでリリースされています。
