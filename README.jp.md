◆→bekkou: 直訳より日本語としても伝わりやすそうな部分は表現を変えています。←◆  
◆→bekkou: websockets と websocket が混じっていますが、websocket が正しいのでしょうか？←◆  
◆→bekkouTODO ソースコード中の文字列リテラルを日本語にする←◆  
◆→bekkou: TODO サーバー/サーバ といった表記のゆれを統一する←◆  
 * ユーザー／ユーザ  
 * ネームスペース／名前空間  
 * フォルダ・ディレクトリ→ディレクトリ  
 * development／__development__ ←あ、これはこういう記法なのかな  
 * メソッド／関数
◆→bekkou: TODO 英単語と日本語の間に半角スペースを入れる。個人的な感覚なのですが、英単語の前後はスペースをあてる。英単語＋日本語の単語は前だけにスペースをあてる。日本語＋英語＋日本語の単語はスペースをあてない。という基準でスペースをあてると読みやすいと感じます ←◆  
◆→bekkou: 文言未確定は ★ をつけました←◆  
◆→bekkou: '' で囲っているやつと囲っていないやつはニュアンスが何か違うの？　メソッド名に付いていたり付いていなかったり。どちらかに統一したいなぁ。あとは xxx() メソッド とか xxx メソッドとかも統一したい←◆  

![SocketStream!](https://github.com/socketstream/socketstream/raw/master/new_project/public/images/logo.png)


Latest release: 0.1.7   ([view changelog](https://github.com/socketstream/socketstream/blob/master/HISTORY.md))

Twitter: [@socketstream](http://twitter.com/#!/socketstream)
Google Group: http://groups.google.com/group/socketstream
IRC channel: [#socketstream](http://webchat.freenode.net/?channels=socketstream) on freenode


### イントロダクション

SocketStrem は、[Single-page Application](http://en.wikipedia.org/wiki/Single-page_application)パラダイムにあわせて開発された新しいフルスタックWebフレームワークです。
websocket や、インメモリデータベース（Redis）、クライアントサイドでのレンダリングを取り入れることで、驚くほどのレスポンスを実現しています。

Project status: 利用可能ですが実験段階です。日々改善しています。

最近の開発状況や思想は[@socketstream](http://twitter.com/#!/socketstream)よりご覧になれます。近日中に Webサイトを公開します。

### 特徴

◆→bekkou: 箇条書きの句点は削るほうがいいと思います。←◆  
◆→bekkou: です／ます で統一しました←◆  

* websockets（またはflashsockets）を使った双方向通信です
* 非常に高速です！　起動は一瞬です。スローダウンの原因になるリクエストごとの HTTPハンドシェイク/ヘッダ/ルーティングはありません
* Chrome と Safari で問題なく動きます。Firefox や IE のサポートは不安定ですが、[Socket.IO](http://socket.io/)を用いて改善しつづけています
* 全てのコードは[CoffeeScript](http://jashkenas.github.com/coffee-script/) もしくは JavaScript にて記述します。好きな方を選んでください
* クライアント／サーバー間でコードを簡単に共有できます。ビジネスロジックやモデルの検証に最適です
* 3G回線の iPad や iPhone の Mobile Safari（iOS 4.2 以上）でも問題なく動きます
* オートマチック HTTP/HTTPS API。全てのサーバーサイドコードは高速なリクエストベースの API を介してアクセスできます
* スケーラブルでプライベートチャンネルを含む pub/sub システムを手軽につかえます。下記の例を参照してください
* 統合されたアセットマネージャー。全てのクライアントサイドアセットは自動的にパッケージングされ[ミニファイされます](https://github.com/mishoo/UglifyJS)
* 自動HTTPリダイレクトによってすぐに使える HTTPS をサポートしています。下記の HTTPS のセクションを参照してください
* モジュール化された認証システムによる組み込みユーザーモデル。ユーザーのオンライン状態を自動的にトラッキングします（下記を参照してください）
* 対話的コンソール。'socketstream console' とタイプするだけで、任意のサーバーサイド／共有メソッドを呼び出せます
* 'API ツリー' によって、フロントからバックエンドをまたぐ巨大なコードベースの名前空間を、シンプルで一貫したものにできます
* セッションの検索、pub/sub、オンラインユーザーの一覧表示など、即時性が要求されるデータの扱いには [Redis](http://www.redis.io/) を使います
* カスタム HTTP middleware/responders をサポートします。これらは柔軟性とスピードを最大限にするために最初に実行されます
* jQuery と [jQuery templates](http://api.jquery.com/category/plugins/templates/) が含まれています。これは Rails の partial のように動きます
* [Underscore.js](http://documentcloud.github.com/underscore/) のようなクライアントライブラリを簡単に追加できます
* 初期HTMLレイアウトは [Jade](http://jade-lang.com/) かプレーンHTML で書けます
* [Stylus](http://learnboost.github.com/stylus/) を CSS生成に使えます
* MITライセンスです


### どのように動作するの？

ユーザーの初回アクセス時、SocketStream は全ての静的 HTML、CSS、クライアントサイドコードを自動的に圧縮しミニファイして送信します。

その後、全てのデータはシリアライズされた JSONオブジェクトとして websocket（もしくは 'flashsocket'）トンネル経由でやりとりされます。
トンネルはクライアントが接続した直後に生成されます。また、切断しても自動的に再生成されます。

つまり、コネクションレイテンシ、HTTPヘッダによるオーバーヘッド、扱いにくい◆→bekkou: 訳すのが難しいですね。。仕組みをちゃんとわかっていないのでどう訳したものか悩んでます。「余分な」、「ださい」、「不格好な」←◆AJAX呼び出しが無いのです。
SocketStream は、正真正銘の双方向で非同期な'ストリーミング'通信をクライアント／サーバ間で可能にします。

### 何をつくれるの？

SocketStream が得意なのはリアルタイムデータ（チャット、株式取引、位置のモニタリング、分析など）を扱うモダンなアプリケーションです。
ブログ等、SEO のためにユニークな URL を必要とするコンテンツリッチなサイトには、今のところ向きません。

### チュートリアル

[SocketStream でつくるリアルタイムな CoffeeScript Webアプリケーション](http://addyosmani.com/blog/building-real-time-coffeescript-web-applications-with-socketstream/) by [Addy Osmani](http://addyosmani.com)


### サンプルアプリ集

これらのアプリは今のところ小さなものですが、コードを読むことで SocketStream の学習に役立つでしょう。

[SocketChat](https://github.com/addyosmani/socketchat) - シンプルなグループチャット

[Dashboard](https://github.com/paulbjensen/socketstream_dashboard_example) - 設定可能なウィジェットを持つリアルタイムダッシュボード

[SocketRacer](https://github.com/alz/socketracer) - マルチプレイヤーレーシングゲーム


### ざっくりわかるSocketStream

SocketStream を使いこなす鍵になるのが 'SS' グローバル変数です。これはサーバ／クライアントサイドのどこからでも呼び出せます。

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
    console.log "#{number} squared is #{response}"
```

サーバーを再起動してページをリフレッシュした後、次のコードをブラウザのコンソールから入力してください。

``` coffee-script
SS.client.app.square(25)
```

以下のように出力されたと思います。

    25 squared is 625

注意深い人なら SS.client.app.square(25) が実際には 'undefined' を返していることに気がつくでしょう。この動作は正常です。注目すべきはリクエストが処理された後にサーバーから非同期に送られるレスポンスです。

サーバーサイドで作成したメソッドは組み込みの HTTP API を使って下記の URL で呼び出すこともできます。

``` coffee-script
/api/app/square?25                        # ヒント: .json を使うとファイルに出力できます
```

サーバーサイドのコンソール('socketstream console' とタイプ)や、ブラウザのコンソール、他のサーバーサイドのファイルから呼び出すこともできます。

``` coffee-script
SS.server.app.square(25, function(x){ console.log(x) })
```

注釈: ブラウザから SS.server メソッドを呼び出した場合、'console.log' コールバックが自動的に挿入されます。

'SS' 変数が jQuery の '$' に似ていることに気がつかれたかもしれません。'SS' は SocketStream API にアクセスする主要な方法です。API がクライアント／サーバ間でなるべく同じになるようにつくられています。◆→bekkou: we do our best のニュアンスを削り過ぎかな。。←◆◆→arumons:そうだね。なるべくニュアンスを残したいなあ。◆

さあ、もっと深い内容に進みましょう。準備はいいですか？　それでは HTML5 Geolocation◆→bekkou: HTML5 Geolocation が正式名っぽかったので変えました←◆を使ったリバースジオコーディング（Reverse geocoding）を見てみましょう。


### 例: リバースジオコーディング

サーバーコードとして /app/server/geocode.coffee を作成して下記のコードをペーストしてください。

``` coffee-script
exports.actions =

  lookup: (coords_from_browser, cb) ->
    host = 'maps.googleapis.com'
    r = coords_from_browser.coords
    http = require('http')
    google = http.createClient(80, host)
    google.on 'error', (e) -> console.error "Unable to connect to #{host}"
    request = google.request 'GET', "/maps/api/geocode/json?sensor=true&latlng=#{r.latitude},#{r.longitude}"
    request.end()
    request.on 'error', (e) -> console.error "Unable to parse response from #{host}"
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
    alert 'Oh dear. Geolocation is not supported by your browser. Time for an upgrade.'

# プライベートな関数

success = (coords_from_browser) ->
  SS.server.geocode.lookup coords_from_browser, (response) ->
    console.log response
    alert 'You are currently at: ' + response.formatted_address

error = (err) ->
  console.error err
  alert 'Oops. The browser cannot determine your location. Are you online?'
```

コードを実行すると現在地が表示されます（WiFi 環境下なら、より正確な位置になります）。もちろん実際にはクライアントへのコールバックの処理を実行中に起こりうる様々なエラーに対応する必要があるでしょう。

おまけ: 再実行はどうすればできるでしょうか？　'SS.client.geocode.determineLocation()' とブラウザのコンソールでタイプするだけです。すべての 'exportされた' クライアントサイドの関数はこの方法で呼び出せます。


### 例: Pub/Sub

チャットアプリやユーザーへのプッシュ通知を作るにはどうすればよいでしょうか？◆→bekkou: 作りたいですか？というノリは日本語ではあまり見ないのでいったんこうしてみました←◆

まず始めにクライアント側で 'newMessage' イベントをリッスンしましょう。

``` coffee-script
exports.init = ->
  SS.events.on('newMessage', (message) -> alert(message))
```

通知を行いたいユーザーの ID を知っていると仮定します。サーバーサイドで次のように書くことでユーザーにメッセージを通知できます。

``` coffee-script
exports.actions =

  testMessage: (user_id) ->
    SS.publish.user(user_id, 'newMessage', '超カッコイイ！')
```

ね、簡単でしょう？　魅力はこれだけではありません。ユーザーがどのサーバーに接続しているかを気にする必要はありません。SocketStream サーバーは Redis の共通インスタンスを見ているのでメッセージは常に正しいサーバーへ送られます。◆→bekkou: こういうことを言いたいような気がするが、仕組みをちゃんと知らないので自信はない←◆

全ユーザーへブロードキャストする方法や、プライベートチャンネルを実装する方法を知りたいですか？　それなら後述の 'More Pub/Sub'★ セクションを読んでください。


### 動作環境

[Node 0.4](http://nodejs.org/#download) か、それ以降のバージョン（0.5.1 でも動作しますが、0.4.x を推奨します）

[NPM 1.0](http://npmjs.org/) （Node Package Manager）か、それ以降のバージョン

[Redis 2.2](http://redis.io/) か、それ以降のバージョン


### SocketStrem を動かそう

SocketStream を試す準備はいいですか？　SocketStrem はまだ実験段階にありますが、私たち開発チームは新しいプロジェクトに SocketStream をつかい、日々改善しています。

SocketStream は NPMパッケージとして公開されています。インストールは以下のコマンドをタイプするだけです。

    sudo npm install socketstream -g

新規の SocketStream プロジェクトを作成するには次のようにタイプしてください。

    socketstream new <name_of_your_project>

生成されるディレクトリの構成は Railsユーザーにはおなじみでしょう。構成の概要は下記のとおりです。

#### /app/client
* /app/client ディレクトリ配下の全ファイルはクライアントに送られます。CoffeeScript ファイルは自動的に JavaScript ファイルに変換されます
* 使いたい JavaScript ライブラリは /lib/client に配置してください
* 開発モードにてブラウザコンソールから着信/発信の呼び出しを見てください
◆→bekkou: 「内部／外部の関数呼び出しの確認は、開発モードでブラウザのコンソールから行えます」ってこと？　incoming/outgoing のニュアンスが難しい←◆
* SS.client.app.init() 関数は、websocket コネクションの確立時に自動的に一度だけ呼び出されます
* 従って、/app/client/app.coffee（もしくは app.js）ファイルは必須です
* /app/client 配下にディレクトリを作成できます。詳しくは Namespacing◆→bekkou: セクション名が決まったら変える←◆ セクションを参照してください。

#### /app/server
* このディレクトリに配置されたすべてのファイルは、昔ながらの MVCフレームワークにおけるコントローラと同じように動作します
* 例えばクライアントから app.init に引数 25 を渡して呼び出すには、SS.server.app.init(25) とクライアント上で実行します
* すべてのメソッドは自動的に HTTP の API としてもアクセス可能になります（e.g. /api/app/square.json?5）
* すべてのメソッドは事前にロードされるので、コンソールや他のサーバーサイドのファイルから SS.server 経由でアクセスできます
* メソッドに値◆→bekkou: incoming params ってなんぞ？←◆が渡されると、それらは最初の引数にまとめられます。最後の引数は常にコールバック関数（cb）です
* すべてのパブリックなメソッドは 'exports.actions' のプロパティとして定義されます。プライベートなメソッドはそのスコープの外側に配置されます。定義は 'methodname = (params) ->' と書きます
* サーバー側のファイルはネストできます。例えば SS.server.users.online.yesterday() と書けば、/app/server/users/online.coffee に定義された yesterday メソッドが呼び出されます
* 同じファイルの中で名前空間をわけるためにオブジェクトをネストすることもできます
* @getSession でユーザー◆→bekkou: User はクラスの User？　それならユーザじゃなくて User と表記したい←◆のセッションにアクセスできます
* @user でカスタムユーザーのインスタンスにアクセスできます。詳細は近日中に公開します

#### /app/shared
* 'コード共有'★ セクションを見てください

#### /app/css
* /app/css/app.styl は必須です。これは SASS に似た [Stylus](http://learnboost.github.com/stylus/) フォーマットで書きます◆→bekkou: 仕組み的にあってるのかな？←◆
* 外部Stylusファイルは app.styl で @import 'name_of_file' と書くとインポートできます。ファイルはネストできます
* CSSライブラリ（例: reset.css や jQuery UI など） を使いたい場合、それらを /lib/css に配置するか、ホスティングされている CDNファイルへのリンクを /app/views/app/jade に書いてください
* Stylusファイルは自動的にコンパイルされ、developmentモードの場合、そのまま送られます。staging もしくは production モードの場合、プリコンパイル、圧縮、キャッシュされます◆→bekkou: 仕組みを試してからもう一度見直したほうがいいかも←◆

#### /app/views
* /app/views/app.jade もしくは /app/views/app.html は必須です。アプリの初期表示するための静的HTML を書いてください
* [Jade](http://jade-lang.com/)（HAML に似ています）フォーマットを使えます（正しい HTML構文が保証されるため使用をオススメします）
* HTML の HEADタグには Jade では '!= SocketStream' を、プレーンHTML では '<SocketStream>' を含めます。このヘルパーによって環境（SS_ENV で指定します）ごとにライブラリをただしく読み込みます
* Jade と HTML 両方で jQuery template（Rails の partial に似ています）を使って別ファイルにわけた HTML を簡単に取り込めます。例えば /app/views/people/customers/info.jade に書いた部分テンプレートは $("#people-customers-info").tmpl(myData) とアクセスできます
* ビューとテンプレートは自動的にコンパイルされ、developmentモードの場合、そのまま送られます。staging や production モードの場合、プリコンパイル、圧縮、キャッシュされます◆→bekkou: 仕組みを試してからもう一度見直したほうがいいかも←◆

#### /lib
* /lib/client や /lib/css 配下のファイルを変更すると、自動的に再コンパイル、パッキング、ミニファイされます
* 新規ファイルをそれらのディレクトリに追加しても上記の処理は行われません（したがってサーバの再起動が必要です）。現在開発チームが対応しています
* ライブラリ名の先頭に数字をつけることで、ライブラリの読み込み順を簡単に指定できます（例: 1.jquery.js, 2.jquery-ui.js）
* クライアント側の JSファイルは、ファイル名に '.min' が含まれていないと [UglifyJS](https://github.com/mishoo/UglifyJS) によって自動的にミニファイされます
* /lib/server 配下の全ファイルは、Node でフルパスを指定せずに require できます。カスタム認証モジュールや、クライアントに公開せずにサーバーサイドのファイル間でコードを共有する方法として理想的です

#### /public
* 静的ファイルを配置してください（例: /public/images, robots.txt など）
* /index.html と /public/assetsディレクトリは SocketStream によって管理されるので変更を加えないでください

#### /static
* 警告や通知用のファイルを格納します。サイトに応じて変更を加えてください

#### /vendor
* ベンダ製のライブラリは /vendor/mycode/lib/mycode.js のフォーマットに沿って配置してください
* このディレクトリの使用は任意です


アプリを起動する前にローカルで Redis2.2+ が起動していることを確認したら下記のコマンドをタイプします。

    socketstream start


正常に起動すると SocketStream のバナーが表示され SocketStream を始める準備ができました！


### 設定ファイル

SocketStream はデフォルトで __development__モードで稼働し、すべての着信と発信★◆→bekkou: incoming はクライアントからのリクエストで、 outgoing はサーバのレスポンスということ？←◆のリクエストはターミナルに表示され、サーバサイドで発生したあらゆる例外はブラウザのコンソールに表示され、すべてのクライアントアセット◆→bekkou: アセットは一般的？←◆はデバッグ用にそのままコンパイルされます。◆→bekkou: __development__ というように __ が付いているのと付いていないのはどう違う？←◆

__development__モードの他に __staging__ と __production__ の二つのモードを利用できます。それぞれモードごとの用途にあった設定で SocketStream をロードします。

プリセット変数の上書きや追加は、設定ファイルを書き換えることで行えます。アプリケーション全体に適用される設定ファイルは /config/app.coffee で、それぞれの環境に適用される設定ファイルは /config/enviroments/<SS_ENV>.coffee です（例: /config/environments/development.coffee）。なお、<SS_ENV>.coffee は app.coffee の設定を上書きします。

__development__モード以外の環境で SocketStream を立ち上げるには SS_ENV環境変数★を使います。

    SS_ENV=staging socketstream start

追加できる環境の数に制限はありません。どの環境で動作しているかは SocketStreamコンソール上で SS.env とタイプすると容易に確認できます。

すべての設定可能な環境変数★は近日公開予定のサイトにてお知らせします。現在は SocketStreamコンソール上で SS.config とタイプすることですべての設定可能な環境変数★を確認できます。

README を読んでいると、環境変数★を変更しているような下記の表記をたびたび目にするでしょう。

    SS.config.limiter.enabled = true

この場合、設定ファイルで次のように書くことで環境変数★の値を変更できます。

``` coffee-script
exports.config =
  limiter:
    enabled: true
```

### ロギング

クライアントとサーバーサイドのロギングは __development__ と __staging__ モードではデフォルトでオン、__production__ モードではオフになっています。
ロギングの設定は SS.config.log.level と SS.config.client.log.level の値によって変更できます。
ロギングのレベルには 0 から 4 までの 5段階◆→bekkou: 原文には Four levels とあるが、最高レベルは 4 で、段階は 5 あるというニュアンスかな。←◆を設定できます。数字が大きいほど冗長なロギングをします。デフォルトのレベルは 3 です。

木を見ず森を見られるように◆→bekkou: ことわざを遊ばせた表現を使うか、「細かいことに煩わされず何が起きているのかちゃんと知るために」とわかりやすい表現にするか悩む。。←◆ 、頻繁に繰り返されるサーバーへのリクエスト（例: 位置情報の送信）の度にロギングしたくない時もあるでしょう。その場合は次のように 'silent' オプションを SS.serverコマンドに追加します。

``` coffee-script
SS.server.user.updatePosition(latestPosition, {silent: true})
```

### Redisとの通信

Redis は、サーバサイドからグローバル変数R でアクセスできます。

``` coffee-script
    R.set("string key", "string val")

    R.get("string key", (err, data) -> console.log(data))    # 'string val' を出力する
```

Redis のホスト、ポート番号、データベース／キースペースのインデックスは SS.config.redis によって設定できます。development／staging／production ごとにデータを格納するために SS.config.redis.db_index の値を設定したくなるかもしれません。

key や pub/subチャンネルなど、SocketStream が内部で使用する全てのキーの先頭には 'ss:' が付きます。それ以外のダブらないキーをアプリケーション内で使えます。

[Redis の全コマンド一覧](http://redis.io/commands)


### データベースとの接続

かゆいところに手が届くような DB 接続フレームワークの開発は、将来のリリースで重要視しています。ですが現在は mongoDB の接続のみサポートしています。

/config/db.coffee（もしくは .js）が存在する場合、起動時に自動で読み込まれます。下記のようにデータベースの設定を書けます。

``` coffee-script
mongodb = require('mongodb')   # installed by NPM
Db = mongodb.Db
Connection = mongodb.Connection
Server = mongodb.Server
global.M = new Db('my_database_name', new Server('localhost', 27017))
M.open (err, client) -> console.error(err) if err?
```
これによってグローバル変数M で mongoDB にアクセスできるようになります。

/config/db.coffee は対象の環境の設定ファイルが読み込まれた後にロードされます。例えば development モードにおける DB接続の設定は /config/environments/develpment.coffee に次のように書けます。

``` coffee-script
exports.config =
  db:
    mongo:
      database:     "my_database_name"
      host:         "localhost"
      port:         27017
```

development.coffee で定義した値を使って /config/db.coffee の設定を行えます。

``` coffee-script
config = SS.config.db.mongo
global.M = new Db(config.database, new Server(config.host, config.port))
```

CouchDB や MYSQL 等、その他の DB についてはテストをしていませんが、動作の原理は一緒です。


### 名前空間（クライアントサイドのコードと共有コード）

JavaScriptベースの Webアプリ開発というエキサイティングな世界には、ファイルをどこに配置して、プロジェクトの成長に合わせてどのように構成していくのかという誰もが頭をかかえる問題があります。

SocketStream は、全てのクライアントサイドのファイルと共有ファイルを「APIツリー」に対応づけるという新しいアプローチをとっています。APIツリーはグローバル変数 SS.client と SS.shared で参照できます。サーバサイドのコードは少し異なる動作をしますが、基本的には同じです（SS.server で参照します）。◆→bekkou: 参照の仕方は似ているが、動作は微妙に違うのかな？←◆

使い方はシンプルです。'exports.' をプリフィックスにしていないすべてのブジェクト、関数、変数は自動的にプライベートになります。'exports.' をプリフィックスにすることでそれらは APIツリーに追加され、同じ環境のあらゆるファイルからアクセスできるようになります。

たとえば /app/client/navbar.coffee というファイルを作成し、下記のコードを追加します。

``` coffee-script
areas = ['Home', 'Products', 'Contact Us']

exports.draw = ->
  areas.forEach (area) ->
    render(area)
    console.log(area + ' has been rendered')

render = (area) ->
  $('body').append("<li>#{area}</li>")
```

'exports.' をプリフィックスにしている 'draw'メソッドはパブリックになるので、クライアントサイドのコードやブラウザのコンソールから呼び出せます。'areas' 変数と 'render' 関数はプライベートなので、グローバルの名前空間は汚染されません。

ディレクトリがネストした名前空間や深いオブジェクトツリーもサポートしています。SocketStream は起動時に、名前空間の衝突がないかどうかチェックします。わたしたち開発チームは、APIツリーが最もクールな機能の一つだと考えています。ぜひご意見・ご感想をお寄せください。

**まめ知識** キーストロークをとことん少なくしたいなら、SS.client のエイリアスをつくりましょう。

``` coffee-script
window.C = SS.client

C.navbar.draw()
```

### コードの共有

SocketStream の強力な機能の一つに、クライアント／サーバ間で同じ JavaScript/CoffeeScriptコードを共有できることがあげられます。クライアントとサーバの両方に都度コピーすればもちろん共有できますが、SocketStream はより素晴らしいソリューションを提供します。

共有コードの書き方や名前空間のマッピングはクライアントサイドのコードのそれらと同じですが、共有コードはクライアントとサーバ、両方の環境で動作します。使い方はシンプルで、/app/shared 配下にファイルを追加し、共有したい関数・プロパティ・オブジェクト・CoffeeScriptのクラスなどを export するだけです。

たとえば /app/shared/calculate.coffee というファイルを作成し、次のコードをペーストしてください。

``` coffee-script
exports.circumference = (radius = 1) ->
  2 * estimatePi() * radius

estimatePi = -> 355/113
```

これによってサーバとクライアントの両方から SS.shared.calculate.circumference(20) を呼びだせます！　コードの共有は、計算ロジック、フォーマット用ヘルパー、モデルのバリデーションといったものに適しています。なお、DOM、バックエンドで動く DB、Node.js のライブラリなど、どちらかの環境だけで動作する処理は共有しないでください。共有コードはサーバとクライアントの両方で動作する 'ピュア' なコードにしてください。

すべての共有コードは事前にロードされ APIツリーの SS.shared に追加されるので、サーバやブラウザのコンソールからいつでも呼び出せます。APIツリー上に estimatePi() が無いことに気づかれたかもしれません。なぜ無いのかというと、estimatePi() はプライベートで定義されているからです（コード自体はクライアントへ転送されています）。

**注意** /app/shared 内の全てのコードは、最初の接続時に圧縮されてクライアントへ送られます。誰かに見られたら困るコード、データベース／ファイルシステムの呼び出しなどは含めないでください。


### ヘルパー

SocketStream には JavaScript で作られたヘルパーメソッドが数多く用意されています。ヘルパーメソッドはプロジェクトの新規作成時につくられます。ヘルパーのコンセプトは Rails の ActiveSupport によく似ています。

ヘルパーはデフォルトでサーバサイドの SocketStream 全体で使われますが、クライアントサイド、共有コード、サーバコードでも同じように使えます。どこで実行できるかを気にする必要がありません。◆→bekkou: あれ。server-side と server code は同じ意味だと思っていたのだけど違うのかな。。二回出てきたので文章として矛盾が生じてるように見えるのでどうしたものか。。←◆

利用できるヘルパーは /lib/client/3.helpers.js を読むと確認できます。もしサードパーティのライブラリと競合してしまったり、ヘルパーそのものが不要なら、ファイルを削除してしまって問題ありません。


### セッション

ブラウザがサーバへ最初に接続したときに新しいセッションがつくられ、クライアントサイドではセッション用のクッキーが保存され、その詳細が Redis に永続化されます。同じブラウザから再度アクセスがあった場合（もしくはブラウザがリフレッシュした場合）、セッションは Redis からすぐに取り出されます。

現在のセッションオブジェクトは、サーバサイドで @getSession関数を呼び出すと取得できます。

``` coffee-script
exports.actions =

  getInfo: (cb) ->
    @getSession (session) ->
      cb("#{session.created_at} につくられたセッションです。")
```

### モジュール化されたユーザ認証

ユーザのログイン・ログアウト機能を必要とする Webアプリケーションは多いでしょう。そのため私たちは 'カレントユーザ' という概念を SocketStream に取り入れました。これは、開発をやりやすくさせるだけでなく、ちゃんとした pub/subシステムの開発、APIリクエストの認証、オンラインユーザのトラッキング（後述するセクションを参照してください）をするために欠かせないものです。

認証はモジュール化されているのでサクッと実装できます。たとえば、お手製の認証モジュールを /lib/server/custom_auth.coffee につくってみましょう。

``` coffee-script
exports.authenticate = (params, cb) ->
  success = # DB アクセスなど何かやる
  if success
    cb({success: true, user_id: 21323, info: {username: 'joebloggs'}})
  else
    cb({success: false, info: {num_retries: 2}})
```

* クライアントから送られるパラメータが第一引数に渡されていることに注目してください。一般的なパラメータは {username: 'something', password: 'secret'} といった値ですが、バイオメトリックID・iPhoneデバイスID・SSOトークンなど他のパラメータを追加できます。

* 第二引数はコールバック関数です。コールバック関数には必ず 'status' パラメータ（boolean）◆→bekkou: ソースコードは success になっているけど。。←◆ と 'user_id' パラメータ（数もしくは文字列）渡す必要があります（'user_id' パラメータは認証が成功した場合のみ）。さらに、残りログイン試行回数など他のパラメータを追加してクライアントに送り返せます。

つくった認証モジュールを使うには、/app/server 内のコードで @getSession を呼び出して session.authenticate の第一引数にモジュール名を渡します。

◆→bekkou: 以下のソースコードがだいぶ違っていたのですが他のコードは大丈夫ですか？　シンプルにコピペしていたら違わないと思うのですが。。README.md を正としますね。←◆  
``` coffee-script
exports.actions =

  authenticate: (params, cb) ->
    @getSession (session) ->
      session.authenticate 'custom_auth', params, (response) =>
        session.setUserId(response.user_id) if response.success       # session.user.id をセットして pub/sub を開始する
        cb(response)                                                  # 追加情報をクライアントに送る

  logout: (cb) ->
    @getSession (session) ->
      session.user.logout(cb)                                         # pub/sub を切断してまっさらな Sessionオブジェクトを返す
```

このようなモジュール化のアプローチによって、複数のユーザ認証を行えます。今後、Facebookコネクトのような共通認証サービスをサポートする予定です。

__重要__

認証が必要な /app/server 配下のファイルには下記のコードを先頭に書いてください。

``` coffee-script
exports.authenticate = true
```

それによってファイル内のメソッドが実行される前に、ログインチェックが行われるか、もしくは（Basic認証などで）プロンプトが表示されます。

一度ユーザが認証されれば、/app/server 配下のファイルより @getSession で session を取得して、session.user_id にアクセスするとユーザID を取得できるようになります。


### オンラインユーザのトラッキング

ユーザがログインできるなら、オンラインのユーザをトラッキングしたくなるでしょう --- リアルタイムチャットやソーシャルアプリをつくっているなら特にそうでしょう。幸運にもトラッキング機能は SocketStream に組み込まれています。

ユーザーが認証に成功すると、そのユーザのID が Redis に永続化されます。オンラインユーザのリストは、サーバーサイドで次のメソッドを呼び出すことで取得できます。

``` coffee-script
SS.users.online.now (data) -> console.log(data)
```

ログアウトしたユーザは即座にリストから取り除かれます。さて、ユーザがブラウザを閉じた場合や、回線が切断した場合はどうなるのでしょうか？

SocketStream のクライアントは、超軽量な 'heartbeat' シグナルをデフォルトで 30秒ごとにサーバに送ることで、ユーザがオンラインであることを伝えます。サーバサイドでは1分ごとに起動するプロセスでシグナルをチェックしており、1分間応答のないユーザをリストから取り除きます。それらのタイミングは SS.config.client.heartbeat_interval と SS.config.users.online の値で調節できます。

注釈: 'オンラインユーザ' 機能は、オーバーヘッドが最小になるようにデフォルトでオンになっています。この機能が不要なら、configファイルの SS.config.users.online.enabled の値に false を設定してください。


### Pub/Sub をもっと知る

前述した SS.publish.user()メソッドに加えて、ユーザにまとめてメッセージを送る方法が二つあります。◆→bekkou: command はコンソールでたたくコマンドではなく、メソッド的な意味の「命令」だと思います←◆

全ユーザに通知するには（例えば、サーバーメンテナンスによるシステムダウンを全員に通知する場合）、broadcast メソッドを使います。

``` coffee-script
SS.publish.broadcast('flash', {type: 'notification', message: 'お知らせ: サービスは10分間ご利用できません。'})
```

複数の部屋があるチャットアプリで、特定の部屋だけにメッセージを通知したいこともあるでしょう。まさにそのための機能としてプライベートチャンネルがあり、複数のサーバに対して最小のオーバーヘッドで通知できます。

シンタックスは先ほど紹介したメソッドと似ています。チャンネル名（もしくはチャンネル名の配列）を第一引数に与えてください。

``` coffee-script
SS.publish.channel(['disney', 'kids'], 'newMessage', {from: 'mickymouse', message: 'Tom をどこかで見なかったかい？'})
```

ユーザはチャンネルを無制限に登録できます（/app/server 配下でのみ動作します）。

``` coffee-script
    @getSession (session) ->

      session.channel.subscribe('disney')        # 注釈: 配列も渡せます

      session.channel.unsubscribe('kids')        # 注釈: 配列も渡せます

      session.channel.list()                     # クライアントが登録しているチャンネル一覧を表示
```

指定したチャンネルが存在しない場合、チャンネルは自動的に作成されます。チャンネルの名前には、有効な JavaScript のオブジェクトキーを使えます。もしクライアントが切断して別のサーバのインスタンスへ再接続した場合でも以前のセッションID を保持している限り、同じチャンネルへ再登録されます。これらのメソッドを使うときは、エラーを必ずハンドルしてください。

**注釈**

SocketStream の Pub/Subシステムは、水平方向へのスケーラビリティと高いスループットを念頭においてデザインされました。今後クラスタリングできるようになった時、'broadcast' と 'channel' は複数のSocketStream のインスタンスをまたがって自動的にロードバランシングされるでしょう。

注意すべきことは、送ったメッセージは保存されずログにも残らないことです。もしクライアントがオフラインだと、メッセージはキューに残ることなく失われます。もしリアルタイムなチャットアプリをつくるなら、メッセージを送る前にデータベースかメッセージングサーバに格納することをオススメします。


### HTTP API

HTTP APIは、サーバサイドの全アクションを、おなじみの HTTP/HTTPSリクエストベースのインタフェースでアクセスできるようにします。

HTTP APIはデフォルトで有効になっており、下記の環境変数★で変更できます。

``` coffee-script
SS.config.api.enabled            Boolean       default: true         # HTTP API の有効／無効
SS.config.api.prefix             String        default: 'api'        # URLプリフィックス 例: 左記だと http://mysite.com/api
```

HTTP API はBasic認証もサポートしており、認証後、session.user_id を使うメソッドにアクセスできるようになります。このオプションを使いたい場合、SS.config.api.https_only に true を設定してパスワードが平文のまま送信されないようにすることをオススメします。

'exports.authenticate = true' （上記を参照）を設定することで、そのファイル内のアクションにアクセスする前にサーバがユーザ名とパスワードを要求するようになります。一方 HTTP API では、認証でどのモジュールを使うのかを設定しなくてはいけません。設定ファイルで SS.config.api.auth.basic.module_name 変数に値を入れてください。

◆→bekkou: 今までの流れはコードの前に説明があったので、コードと説明が逆になっていた部分を入れ替えました←◆
``` coffee-script
exports.config =
  api:
    auth:
      basic:
        module_name: "custom_auth"
```

注釈: Basic認証は 'username' と 'password' パラメータを exports.authenticate() 関数に渡します。


### 回線切断時のハンドリング

websocket／'flashsocket'トンネルは障害がおきても驚くほどすぐに回復します。ですが開発者は接続が失敗する可能性をつねに考えなければいけません。特にモバイル機器の回線は不安定です。

**クライアントサイド**

SocketStream のクライアントで利用できる（Socket.IO の機能です） 'disconnect'・'connect' イベントに関数をバインドすることをオススメします。例えば次のようにやります。

``` coffee-script
SS.socket.on('disconnect', -> alert('コネクションが切断されました。'))

SS.socket.on('connect', -> alert('コネクションが確立しました'))
```

オンライン／オフラインのアイコンを切り替えたり、よりよい方法としてはスクリーンを暗くして '再接続中です...' とメッセージを表示したりすることに活用できます。

**サーバーサイド**

SocketStream は（ブラウザのタブが閉じた等で）クライアントが切断されたことを自動的に検知します。その際にユーザをログアウトしたり、データベースをクリーンしたり、メッセージのブロードキャストをしたいでしょう。そんなときは、ユーザがアプリに初めて接続するときに実行される SS.server.app.init() メソッドに次のようなイベントハンドラを登録するとよいでしょう。

``` coffee-script
exports.actions =

  init: (cb) ->
    @getSession (session) ->
      session.on 'disconnect', (disconnected_session) ->
        console.log "ユーザID #{disconnected_session.user_id} はログアウトしました！"
        disconnected_session.user.logout()
```

**注釈**

オフライン時にサーバへリクエストを送ろうとした場合、リクエストはブラウザ内にキューイングされ、再接続したときに自動的に実行されます。近いうちに、株取引アプリなどで必要になるであろう1秒を争うようなリクエストにはマークを付けられるようにする予定です。


### カスタムHTTPハンドラ／ミドルウェアの使い方

私たちはこのアイデアをまだ探求し尽くせていませんが、現在、すべてのHTTPリクエストをミドルウェアへ送ることができます。これによってリクエストオブジェクトを変更したり、さらには、URL・ユーザーエージェント・リクエストパラメータに応じてヘッダとコンテンツを独自に処理することさえできます。

これはとても強力な機能です。HTTPリクエストがきた時に Node ◆→bekkou: Node.js にしなくていい？←◆によって最初に呼びだされるため、ものすごく柔軟で無駄のない Node.jsアプリをつくれます。

この機能を使うときは /config/http.coffee に書かれているコメントを見てください。ミドルウェアの例として、下記の my_middleware.coffee というファイルを /lib/server 配下につくって試してください。◆→bekkou: feature ですよー。future でないですよー。←◆

``` coffee-script
exports.call = (request, response, next) ->

  # Log the User Agent of each incoming request
  console.log 'ユーザエージェント: ', request.headers['user-agent']

  # All middleware must end with next() unless response is being served/terminated here
  next()
```

### 互換性のないブラウザ

デフォルトでは SocketStream はネイティブ websocket（利用可能なら）か 'flashsockets' を使って全てのブラウザにリアルタイムでコンテンツを提供しようとします。

flashsocket はオーバーヘッドや初期接続レイテンシが存在するため、リアルタイムのやり取りには理想的ではありません。そのためStrictモードを使いたくなるかもしれません。

``` coffee-script
SS.config.browser_check.strict = true
```

一度このオプションがセットされると、ネイティブな websocket をサポートしているブラウザ（現在サポートしているのはChrome 4とSafari5 以降のバージョンです）のみがアプリと通信できるようになります。
それ以外のブラウザでアクセスした場合、/static/incompatible_browsers/index.html の内容が表示されます。このファイルは自由にカスタマイズ可能です。

将来的には互換ブラウザを検出するテストの精度向上と、保険として SocketStream クライアントの Flash サポートを改良する予定です。

注釈:HTTP APIリクエストの提供はブラウザの互換性がチェックされる前に行われます。そのためこれらの設定は影響を与えません。


### セキュリティ

正直なところ、SocketStream はどれくらいセキュアなのか私たちは把握していません。Node.js から SocketStream クライアントまでのスタック全体は新しく、製品としての準備が全てできているとは言えません。今はファイアウォールの内側で SocketStream  の運用をすることをお勧めします。

もちろん、冒険してみたいなら、私たちが www.socketstream.org にて公開(予定)しているように SocketStream によるWebサイトを公開することもできます。重要なデータはサーバーに置かないようにし、なにかあった場合はすぐに復元できるようにすべきです。

攻撃されたり、ソースコードの中に脆弱性を見つけたら私たちに教えてください。非常に助かります。そうすることによって SocketStream によるWebサイトの公開が安全に行える日が近づきます。


__XSS攻撃__

クイックリマインダ: SocketStream は他のWebフレームワークと同様にXSS攻撃を受ける可能性があります。悪意を持ったユーザー生成コンテンツ（UGC）は入力時(サーバーサイド)とスクリーンへの出力時（クライアントサイド）でフィルタリングすることをお勧めします。将来的には 'helpers' にフィルタリングの機能を含める予定です。

whileループの中で'SS.server' のメソッドをひたすら呼びつづけるコードを、ユーザーが投稿したリンクの最後に埋め込むのはとても簡単にできます。これが実行されると素敵なことになるでしょう・・・


__レート制限とDDOS防御__

SocketStream は特定のクライアントが一秒に15回以上 websocket の接続を行うとしていることを検知することで、DDOS攻撃に対して防御する機能を持ちます。(回数はSS.config.limitter.websockets.rpsにて設定可能です)

1秒に15回以上の接続が試みられた場合、対象のクライアントがコンソールに表示され、そのクライアントからの全ての連続したリクエストは無視されます。この機能は我々が実際の環境でテスト中のため現在はオフになっていますが、SS.config.limitter.enabled の値をtrueにすることで有効にすることができます。


### HTTPS / TLS (SSL)
上記のセキュリティに関するセクションを読み、SocketStream アプリを（VPNの内側ではなく）インターネットに公開することを決めたのなら、HTTPSはあったら良い程度の機能ではありません。必須の機能です。

その理由は二つ挙げられます。

1. HTTPプロキシー、プロキシは特にモバイル通信会社によって使われ、HTTPリクエストを改変します。その改変によって websocket の初期化はたびたび妨害されます。HTTPS/TLS は通信の内容をだけではなくヘッダも暗号化し、3G回線上のモバイルSafari（iPad や iPhone）からでもwebsocketsが期待通りに動くことを保証します。

2. [FireSheep](http://en.wikipedia.org/wiki/Firesheep)を覚えていますか？　インターネット上に公開する SocketStream アプリのデフォルトをHTTPSにすることでこの問題にけりをつけましょう。

SocketStream でHTTPSを使うのは簡単です。OpenSSLサポートを有効にして./configureとNode.jsのコンパイルを行っていることを確認してください。もしOpenSSLライブラリのインストールがまだなら次のコマンドでインストールすることができます(Ubuntuの場合)

    sudo apt-get install libssl-dev openssl  (ヒント: これを行った後に pkg-config をインストール／起動する必要があるかもしれません)

一度 Node が HTTPS/TLS をサポートしたら、stating もしくは production 環境で SS.config.https.enabled = trueとすることで HTTPS/TLS が有効になります。SocketStream はHTTPSサーバーを通常ポート443で立ち上げようとするため、起動には sudo コマンドを使う必要があるでしょう。

SocketStream は自己署名付きSSL証明書を持っています。これはコマーシャル証明書が見つからない場合にデフォルトでロードされます。これはテスト／デバッグを行うときに役立ちますが、自己署名付き証明書をサポートしていないブラウザで websocket を使う時に問題が発生するかもしれません。


**デプロイ**

アプリを公開する準備ができたら、正当なSSL証明書が必要になるでしょう。開発チームはwww.rapidssl.com](www.rapidssl.com) を好んで使っています。何故ならここは他の有名なプロバイダが行っていないモバイルバージョンのSafari(iPadとiPhone)をサポートしているからです。

商用のSSL証明書を得るには下記のコマンドをプロジェクトのルートディレクトリで実行してください。

    cd config/ssl_certs

    openssl genrsa -out site.key.pem 2048

    openssl req -new -key site.key.pem -out site.request.csr

注釈:Common Name の入力には注意を払ってください。これはあなたのWebサイトのフルドメイン(www.を含む)でなければいけません。

site.request.csr ファイルの内容を認証局に送ると、交換で証明書が手に入ります。それを /config/ssl_certs/site.cert.pem に配置してください。全てのブラウザで証明書の検証が行えるように '中間証明書' も取得し、 /config/ssl_certs/site.ca.pem に配置してください。

全てのファイルが揃うと SocketStream はその証明書を自己署名のテスト証明書の代わりに使い、サーバーの起動時にそのことを通知します。


**strayリクエストのリダイレクト**

HTTPSが有効になったら、'Common Name' として証明書内のリストに載っているドメインに、サイトの訪問者が行く必要があります。'Common Name' は基本的にあなたのサイトの 'www.' バージョンです。SS.config.https.domain にあなたのサイトのFQDN（www.yourdomain.com）を設定することで SocketStream は自動的に http://yourdomain.com へのあらゆるリクエストを https://www.yourdomain.com にリダイレクトします。そうすることで、訪問者は奇妙なセキュリティ警告を見なくて済むようになります。

さらにデフォルトではセカンダリHTTPサーバーをポート番号80で立ち上げ、http:// へ送られたAPIではないトラフィックを https:// へ転送します。リダイレクトが不要ならオフにすることも可能です。(SS.config.httpを見てください。)


**複数の証明書の使用**

複数のSSL証明書を /config/ssl_certs にインストールでき、SS.config.https_cert_name によって SocketStream がどの証明書を使うのか選択することができます。
デフォルトではこの値は 'site' になっています。そのため上記の説明では、ファイル名を site.key.pem、 site.cert_pem にしていました。


### スケールアップ

バックエンドで行う処理やHTTPSを有効にしているかどうかにもよりますが、SocketStreamのインスタンスは一つで数千の同時接続を楽に扱えるはずです。しかし、あなたのアプリが爆発的に広まり、一つのサーバーでは十分でなくなった時はどうするのでしょうか？

バージョン0.2.0は現在この問題に向けて開発中です。数週間中にリリースされるアルファリリースに注目してください。0.2.0のほとんどの部分は0.1.xとAPIの互換性があるため、既存のアプリが壊れることはないでしょう。


### テスト

テストは大事ですが、現在はテストが十分とはいえません。これは良くないことです。現在望ましいとされるテスティングフレームワークの評価を行っています。これからの開発はそのテストフレームワークを元に行うため、選択は慎重に行う必要があります。フレームワークが決まり次第、ユニットテストとインテグレーションテストを変更の可能性が低い部分に対して書き始めるでしょう。この分野についての貢献は非常に助かります。


### 既知の問題

* /lib/clientに追加される新しいファイルはサーバーをリスタートするまで削除されません。近々修正する予定です。
* jQueryを使った$('body')への操作　例: $('body').hide はFirefox4においてflashsocketコネクションを切断させます。この奇妙なバグの原因が何か分かるまで、$('body')の呼び出しは避けるのがベストです。


### FAQs

Q: SocketStreamはJava/Erlang/PHP/Ruby/Python/お気に入りの言語 の内、どれかをサポートする予定はありますか？

A: SocketStreamは使用する技術を慎重に選んでいるスタンドアローンのフレームワークです。既存のアプリ全体をSocketStreamで書き直すよりも、サーバーサイドから容易に呼び出せるレガシーなWebサービスのフロントエンドとして使うことを検討しましょう。


Q: 私は既存のアプリの中にSocketStreamアプリを組み込むことはできますか?

A: 少なくとも同じホストとポート番号を使うことはできません。'ハイブリッド'なリアルタイムアプリのために[Pusher](http://www.pusher.com)を使うことをお勧めします。


Q: 同じポート番号で複数のSocketStream Webサイトをホストすることはできますか？

A: 現在はできません。リバースプロキシを使ってこれをサポートする方法を検討する予定です。


Q: 複数のCPUコアやサーバーによって巨大なWebサイトを水平展開することはできますか？

A: 現在はできませんが、近日公開予定のv 0.2.0で可能になります。


Q: アプリのテストはどのように行いますか？

A: Node.js用に利用可能なテスティングフレームワークの内どれか一つを選んで使うことをお勧めします。開発チームがフレームワークをSocketStreamに組み込むのに役立ちそうなものがあれば教えてください。SocketStreamは組み込みのテスティングフレームワークを持つ予定ですが、それはまったく新しい試みになる思われます。2011年末頃のアナウンスをお見逃しなく。


Q: SocketStreamアプリをHerokuにデプロイできますか？

A: 現在のHerokuはwebsocketを正しく送ってくれないためできません。将来SocketStream/websocketベースのアプリを立ち上げるためのホスティングサービスが立ち上がると確信しています。サービスができた時はここで通知する予定です。


Q: モデルはどうやってつくりますか？

A: サーバーサイドにてモデルを作る方法は現在ありません。これはリアルタイムチャットのようなアプリを作る妨げにはならないでしょう。しかしCRUDを多用するアプリではモデルが無いと困るかもしれません。リアルタイムモデルという素晴らしい方法があるのですが、我々は現在内部でこのアイディアについてテストと調整を行っています。近い将来にお見せできるでしょう。


Q: API / ディレクトリ構造 / コンフィグファイルフォーマットは将来変わりますか?

A: はい。SocketStreamはただの新しいWebフレームワークではありません。それはWebアプリケーションのまったく新しい開発方法を定義するものです。そのためこの１年で新しいアイディアが数多く取り込まれていくと思います。1.0.0がリリースされるまでは変更が落ち着くことはないでしょう。それまでには開発者を巻き込むような大きな変更を行うと思います。可能であれば自動アップグレードを行うためのスクリプトを提供するかもしれません。ベストの方法はHISTORYファイルをチェックし続け、そして何らかの例をオンラインに投稿するときはバージョン番号を引用することです。


Q: SocketStreamは公式サイトを持っていますか？

A: もちろん！www.socketstream.orgにて現在活動中です。:)


Q: websocketはOperaで動作しますか？

A: websocketはサポートされていますが、デフォルトではOFFになっています。Opera 11でwebsocketをONにするには"opera:config#Enable%20WebSockets"とアドレス欄で入力し、"Enable websockets" にチェックをつけて設定をセーブしてください。
そうすればwebsocketが有効になります。

### Core Team

* Owen Barnes (socketstream & owenb)
* Paul Jensen (paulbjensen)
* Alan Milford (alz)
* Addy Osmani (addyosmani)


### 貢献

開発チームはWebの可能性の再定義を目標とし、熱心で先見の明があるハッカーを歓迎します。大きく、大胆で、既存のフレームワークや考えかたに縛られない意見はいつでも歓迎します。最良の開発者は10行のコードを取り除き、3行を必要とするまったく新しいデザインを考えつきます。あなたがこの種の人なら潜在的なコアメンバーとしてあなたを歓迎します。テストを書いてくれる人や、美しいドキュメントを書いてくれる人も最大級の感謝を受け取るでしょう。そして素早く動く標的についていこうとするときにサポートを受けるでしょう。

新しい機能をSocketStreamに追加し、pullリクエストを送る前に、私たちのゴールはコアをムダのない、頑丈で、画期的なほど速いものにし続けるということを再考してください。ノンコアな機能はNPMモジュールによって提供されるべきです。
(微妙)時が立つにつれてそれは可能/容易になるでしょう。

もし思いついたアイディアや、ほかの何かしらについて議論をしたいのならinfo@socketstream.org宛にメールを送ってください。


### Credits

Thanks to Guillermo Rauch (Socket.IO), TJ Holowaychuk (Stylus, Jade), Jeremy Ashkenas (CoffeeScript), Mihai Bazon (UglifyJS), Isaac Schlueter (NPM), Salvatore Sanfilippo (Redis) and the many others who's amazing work has made SocketStream possible. Special thanks to Ryan Dahl (creator of node.js) for the inspiration to do things differently.


### ありがとう！

SocketStreamの開発はAOLの支援によって行われています。


### ライセンス

SocketStreamはMITライセンスの元でリリースされています。
