◆→bekkou: 直訳より日本語としても伝わりやすそうな部分は表現を変えています。←◆

![SocketStream!](https://github.com/socketstream/socketstream/raw/master/new_project/public/images/logo.png)


Latest release: 0.1.7   ([view changelog](https://github.com/socketstream/socketstream/blob/master/HISTORY.md))

Twitter: [@socketstream](http://twitter.com/#!/socketstream)  
Google Group: http://groups.google.com/group/socketstream  
IRC channel: [#socketstream](http://webchat.freenode.net/?channels=socketstream) on freenode


### イントロダクション

SocketStremは、[Single-page Application](http://en.wikipedia.org/wiki/Single-page_application)時代にあわせて開発された新しいフルスタックWebフレームワークです。
websocketや、インメモリデータベース(Redis)、クライアントサイドでのレンダリングを取り入れることで、驚くほどのレスポンスを実現しています。

Project status: 利用可能ですが実験段階です。日々改善しています。

最近の開発状況や思想は[@socketstream](http://twitter.com/#!/socketstream)よりご覧になれます。また、近日中にWebサイトを公開します。

### 特徴

* websockets(もしくはflashsockets)を使うことによる、双方向通信
* 非常に高速です！起動は一瞬です。毎回のリクエストに付属するHTTPハンドシェイク/ヘッダ/ルーティングでのスローダウンはありません。
* ChromeとSafari上でうまく動作します。FirefoxやIEのサポートは不安定ですが、[Socket.IO](http://socket.io/)によって改善しています。
* 全てのコードは[CoffeeScript](http://jashkenas.github.com/coffee-script/) か JavaScriptによって書かれます。好きな方を選んでください。
* クライアントとサーバー間のコードを簡単に共有できます。ビジネスロジックとモデルの検証にとって理想的です。
* 3G回線からでもiPadsやiPhones上のMobile Safari (iOS 4.2 and above)にて、とても良く動作します。
* オートマティックHTTP/HTTPS API.全てのサーバーサイドコードは高速なリクエストベースのAPIとしてもアクセス可能です。 
* お手軽にプライベートチャンネルを含むスケーラブルなpub/subシステムが利用可能です。下記の例を参照してください。
* 統合されたアセットマネージャー。全てのクライアントサイドアセットは自動的にパッケージかつ[ミニファイされます](https://github.com/mishoo/UglifyJS) 
* 自動HTTPリダイレクトによってすぐに使えるHTTPSをサポートしています。HTTPSセクションを参照してください。
* モジュール化された認証システムによる組み込みユーザーモデル。ユーザーのオンライン状態を自動的に追跡します(下記を参照してください)。
* 対話的コンソール。'socketstream console'とタイプするだけで、任意のサーバーサイドや共有メソッドを呼び出すことができます。
* 'API ツリー'によってシンプルで一貫した名前空間が構築されます。
* セッションの検索、pub/sub、オンラインユーザーの管理等、即時性が要求されるデータの扱いには[Redis](http://www.redis.io/)を使用します。
* カスタムHTTP middleware/respondersをサポートします。最大限の柔軟性とスピードのために最初に実行されます。
* jQueryと[jQuery templates](http://api.jquery.com/category/plugins/templates/)がバンドルされます。これはRailsのパーシャルのように働きます。 
* [Underscore.js](http://documentcloud.github.com/underscore/)のようなライブラリの追加も容易に行なえます。
* 初期HTMLレイアウトは[Jade](http://jade-lang.com/)もしくはplain HTMLによって生成されます。
* [Stylus](http://learnboost.github.com/stylus/)をCSS生成に使います。
* MITライセンス


### どのように動作するの？

SocketStreamはユーザーの初回アクセス時、自動的に全ての静的HTML、CSS、クライアントサイドコードを圧縮、ミニファイして送ります。
それ以後、全てのデータはシリアライズされたJSONオブジェクトとしてwebsocket(もしくは'flashsocket')経由でやりとりされます。
websocketはクライアントが接続した時や、切断によって自動的に再接続された時に即座に成立します。
これらが意味するのはコネクションレイテンシ、HTTPヘッダによるオーバーヘッド、扱いにくいAJAX呼び出しなどが存在しないということです。
真に双方向で非同期な'ストリーミング'通信がクライアントとサーバー間で可能になります。

### これで何が作れるの？

SocketStreamはリアルタイムデータ(チャット、株取引、ロケーションモニタリング、分析等)を扱うアプリケーション全てにフィットします。
しかし、ブログやSEOを意識してコンテンツごとにURLを必要とするコンテンツリッチなサイトには現在のところ向きません。

### チュートリアル

[リアルタイムなCoffeeScript WebアプリケーションをSocketStreamで構築する](http://addyosmani.com/blog/building-real-time-coffeescript-web-applications-with-socketstream/) by [Addy Osmani](http://addyosmani.com)


### サンプルアプリ

これらは今のところ小さなアプリにすぎませんが、コードを見ることはSocketStreamを学ぶ上で役に立つと思います。

[SocketChat](https://github.com/addyosmani/socketchat) - シンプルなグループチャット

[Dashboard](https://github.com/paulbjensen/socketstream_dashboard_example) - 設定可能なウィジェットを持つリアルタイムダッシュボード

[SocketRacer](https://github.com/alz/socketracer) - マルチプレイヤーレーシングゲーム


### Quick Example

SocketStreamを使うにあたって鍵となるのは'SS'グローバル変数です。これはサーバーとクライアント両方のどこからでも呼び出すことができます。

例えば、数を二乗するシンプルなサーバーサイドの関数を書いてみます。このコードを/app/server/app.coffeeファイルに追加してください。 


``` coffee-script
exports.actions =

  square: (number, cb) ->
    cb(number * number)
```

これをブラウザから呼び出すために、下記のコードを/app/client/app.coffee追加してください。 

``` coffee-script
exports.square = (number) ->
  SS.server.app.square number, (response) ->
    console.log "#{number} squared is #{response}"
```

サーバーを再起動し、ページをリフレッシュします。そして次のコードをブラウザのコンソールから打ち込んでください。

``` coffee-script
SS.client.app.square(25)
```

下記のように出力されたと思います。

    25 squared is 625
    
注意深い人ならSS.client.app.square(25)が実際には'undefined'を返していることに気がつくでしょう。この動作は正常です。注目すべきはリクエストが処理された後にサーバーから非同期に送られるレスポンスです。

サーバーサイドで作成したメソッドは組み込みのHTTP APIを使って下記のURLで呼び出すこともできます。

``` coffee-script
/api/app/square?25                        # Hint: use .json to output to a file
```
    
サーバーサイドのコンソール('socketstream console'とタイプ)や、ブラウザのコンソール、他のサーバーサイドファイルから呼び出すこともできます。

``` coffee-script
SS.server.app.square(25, function(x){ console.log(x) })
```
    
注釈: ブラウザからSS.serverメソッドを呼び出した場合、'console.log'コールバックが自動的に挿入されます。

'SS'変数がjQueryの'$'に似ていることに気がつかれたかもしれません。これはSocketStream APIにアクセスするためのメインとなる方法です。開発チームはAPIがクライアントとサーバ間で可能なかぎり同一になるよう努力しました。

さらに進んだ内容への準備はできましたか？それではHTML5の位置情報を使った座標解析を見てみましょう。


### Reverse Geocoding Example

サーバーコードを書く準備として、/app/server/geocode.coffeeを作成し、下記のコードを貼り付けてください。 

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

parseResponse = (response, cb) ->  # note: private methods are written outside of exports.actions
  output = ''
  response.setEncoding('utf8')
  response.on 'data', (chunk) -> output += chunk
  response.on 'end', ->
    j = JSON.parse(output)
    result = j.results[0]
    cb(result)
```

位置情報の取得とアドレスを出力するために下記のコードを/app/client/app.coffeeに追加してください。

``` coffee-script
# 注釈: SS.client.app.init()メソッドはsocketの準備ができてセッションが利用可能になった時に自動的に呼び出されます。
exports.init = ->
  SS.client.geocode.determineLocation()
```

次に、純粋にクライアントサイドの名前空間機能を試すため(下記のセクションを見てください)/app/client/geocode.coffeeファイルを作成し、次のコードを
貼り付けてください。

``` coffee-script
exports.determineLocation = ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(success, error)
  else
    alert 'Oh dear. Geolocation is not supported by your browser. Time for an upgrade.'

# Private functions

success = (coords_from_browser) ->
  SS.server.geocode.lookup coords_from_browser, (response) ->
    console.log response
    alert 'You are currently at: ' + response.formatted_address

error = (err) ->
  console.error err
  alert 'Oops. The browser cannot determine your location. Are you online?'
```

このコードを実行すると現在の位置が表示されると思います。(もしWiFi環境下にあるならより正確な位置がでるでしょう)
もちろん、実際にはコールバックでこの処理を実行中に起こり得る様々なエラーに対応する必要があるでしょう。

ボーナス：もう一度実行したいですか？その場合は'SS.client.geocode.determineLocation()' とブラウザのコンソールにてタイプしてください。
全ての'exportされた'クライアントサイドの関数はこの方法で呼び出すことができます。


### Pub/Sub Example

チャットアプリの作成や、特定ユーザーへの通知を希望ですか？
    
最初にクライアント側で'newMessage'イベントを見張るようにしましょう。

``` coffee-script
exports.init = ->
  SS.events.on('newMessage', (message) -> alert(message))
```
          
次に、通知を行いたいユーザーのIDを既に知っていると仮定して、サーバーサイドで次のように書くことで
そのユーザーにメッセージの通知を行うことができます。

``` coffee-script
exports.actions =

  testMessage: (user_id) ->
    SS.publish.user(user_id, 'newMessage', 'Wow this is cool!')
```

簡単でしょう？ユーザーが接続しているサーバーはどれなのかを気にする必要はありません。共通のRedisインスタンスと接続している限り、メッセージは常に正しいサーバーへと送られます。

全てのユーザーへブロードキャストする方法や、プライベートチャンネルの実装方法を知りたいですか？
'More Pub/Sub'セクションを見てください。

### 動作環境

[Node 0.4](http://nodejs.org/#download) or above (should work fine with 0.5.1 but we recommend 0.4.x)

[NPM 1.0](http://npmjs.org/) (Node Package Manager) or above

[Redis 2.2](http://redis.io/) or above


### Getting Started

SocketStreamを試す準備はできましたか？SocketStremはまだ実験段階にありますが開発チームは新しいプロジェクトにSocketStreamを使用し、日々改善を行っています。

SocketStreamはNPMパッケージとして公開されています。インストールは簡単に行なえます。

    sudo npm install socketstream -g

新規のSocketStreamプロジェクトを作成するには次のようにタイプしてください。

    socketstream new <name_of_your_project>

生成されるディレクトリ構成はRailsユーザーにはおなじみでしょう。下記がディレクトリの概要です。

#### /app/client
* /app/clientディレクトリ内の全てのファイルはクライアントに送られます。CoffeeScriptファイルは自動的にJavaScriptファイルに変換されます。
* 使いたいJavaScriptライブラリがあるのならそれを/lib/clientに配置してください。
* 開発モードにてブラウザコンソールから着信/発信の呼び出しを見てください。
* SS.client.app.init()関数はwebsocket回線が成立した時に自動的に呼び出されます。
* 従って、/app/client/app.coffee(もしくは app.js)ファイルは必須です。
* /app/client配下へフォルダを配置するすることも可能です。Namespacingセクションを参照してください。

#### /app/server
* このディレクトリに配置された全てのファイルは、従来のMVCフレームワークにおけるコントローラと似た役割になります。
* 例えば、app.initをクライアントから25を渡して呼び出すにはSS.server.app.init(25)とクライアント上で実行します。
* 全てのメソッドは自動的にHTTP API経由でもアクセス可能になります。(e.g. /api/app/square.json?5)
* 全てのメソッドは事前にロードされ、コンソールや他のサーバーサイドファイルからSS.server経由でアクセス可能になります。
* もしメソッドに値が渡された場合、それらは最初の引数にまとめられます。最後の引数は常にコールバック関数(cb)です。
* 全てのパブリックなメソッドは'exports.actions'のプロパティとして定義されます。プライベートなメソッドはその外側のスコープに配置され、'methodname = (params) ->'で始まります。
* サーバーファイルは入れ子にすることができます。SS.server.users.online.yesterday()という呼び出しは/app/server/users/online.coffeeにて定義されたyesterdayメソッドを呼び出します。
* 同じファイルの中でネームスペースを分割するためにオブジェクトを入れ子にすることもできます。
* @getSessionにてユーザーのセッションにアクセスできます。
* @userにてカスタムユーザーインスタンスにアクセスできます。詳細は近日中に公開されます。

#### /app/shared
* 'コード共有'セクションを見てください。

#### /app/css
* /app/css/app.stylは必須です。これはSASSに似た[Stylus](http://learnboost.github.com/stylus/)フォーマットのスタイルシートを含んでいます。
* Stylusファイルの追加はapp.styleファイルにて@import 'name_of_file'を使うことで可能になります。ファイルのネストも可能です。
* もしCSSライブラリ(e.g. reset.css or jQuery UI) をプロジェクトで使いたい場合、それらを/lib/cssに配置するか、ホスティングされているCDNファイルへのリンクを/app/views/app/jadeにてそのファイルをリンクしてください。
* Stylusファイルは自動的にコンパイルされ、開発モードの場合、そのまま送られます。ステージングもしくは製品モードの場合、プリコンパイル、圧縮、キャッシュが行われます。

#### /app/views
* /app/views/app.jadeもしくは/app/views/app.htmlは必須です。これはアプリが必要とする初期HTMLを含んでいなければいけません。
* HTMLの他に[Jade](http://jade-lang.com/)フォーマット(HAMLに似ています)を使えます。(正しいHTML構文が保証されるため使用をお勧めします。） 
* HTMLのHEADタグはJadeの場合 '!= SocketStream' を、プレインHTMLの場合 '<SocketStream>' を含む必要があります。このヘルパは環境毎に正しいライブラリを読み込むことを保証します。(環境はSS_ENVによって指定されます。)
* JadeとHTML両方でjQuery template(Railsのパーシャルに似ています)を使って追加のHTMLを簡単に取り込むことができます。E.g /app/views/people/customers/info.jade is accessible as $("#people-customers-info").tmpl(myData).
* ビューとテンプレートは自動的にコンパイルされ、開発モードの場合、そのまま送られます。ステージングや製品モードの場合、プリコンパイル、圧縮、キャッシュが行われます。

#### /lib
* /lib/clientや/lib/css配下のファイルを変更すると、自動的に再コンパイル、パッキング、ミニファイが行われます。
* これらのディレクトリへの新規ファイルの追加しても上記の処理は行われません。(従ってサーバーの再起動を行う必要があります)開発チームは現在この問題を修正中です。
* ライブラリの先頭に数字を付与することで、ライブラリの読み込まれる順番を簡単にコントロールすることができます。(e.g. 1.jquery.js, 2.jquery-ui.js)
* クライアント側のJSファイルはファイル名に'.min'を含んでいない限り、自動的に[UglifyJS](https://github.com/mishoo/UglifyJS)によってミニファイされます。
* /lib/server内のあらゆるファイルはNodeによってrequireされます。ファイルのフルパスを渡す必要はありません。カスタム認証モジュールや、クライアントに公開せずにサーバーサイドのファイル間でコードを共有する方法として理想的です。

#### /public
* スタティックファイルをここに配置してください。(e.g. /public/images, robots.txt, etc)
* /index.htmlファイルと/public/assetsフォルダはSocketStreamによって管理されます。これらに対して変更は加えないでください。

#### /static
* このディレクトリは警告や通知用のファイルを格納します。サイトに応じて変更を加えてください。

#### /vendor
* ベンダ製のライブラリは/vendor/mycode/lib/mycode.jsのフォーマットに沿って配置してください。
* このディレクトリの使用は任意です。


アプリを起動する前にあなたのマシン上でRedis2.2+が起動していることを確認したら下記のコマンドをタイプします。

    socketstream start
    

もし正常に起動した場合、SocketStreamのバナーが表示され、SocketStreamを始める準備ができたことになります！


### 設定ファイル

SocketStreamはデフォルトでは__development__モードで稼働します。全ての着信と発信のリクエストはターミナルに表示され、るサーバーサイドで発生したあらゆる例外がブラウザのコンソールに表示されます。 全てのクライアントアセットはデバッグ用にそのままコンパイルされます。

__development__モードの他に__staging__と__production__の二つのモードが利用可能です。二つとも意図された用途の設定にてSocketStreamをロードします。

必要であれば、プリセット変数は二つのファイルにて上書きや追加の設定を行うことができます。アプリケーション全体に適用されるコンフィグファイルは/config/app.coffeeに配置します。
指定した環境に対して適用されるコンフィグファイルは/config/enviroments/<SS_ENV>.coffeeに配置します。(e.g. /config/environments/development.coffee)このファイルはapp.coffeeにて行った設定を上書きします。

__development__モード以外の環境でSocketStreamを立ち上げるにはSS_ENV環境変数を使います。

    SS_ENV=staging socketstream start
    
追加できる環境の数に制限はありません。SocketStreamコンソール上でSS.envとタイプすることでどの環境で動作しているのかを容易に確認することができます。

設定可能な項目は近日公開予定のサイトにてお知らせします。現在はSocketStreamコンソール上でSS.configとタイプすることで設定可能な項目をみることができます。

このREADME全体で下記のようなコンフィグ変数を繰り返し見るでしょう。

    SS.config.limiter.enabled = true

この場合、コンフィグファイルで下記のように書くことで変数の値を変更することができます。

``` coffee-script
exports.config =
  limiter: 
    enabled: true
```

### ログ出力

クライアントとサーバーサイドのログ出力は__development__と__staging__ではデフォルトでオンになり、__production__ではオフになっています。
この設定はSS.config.log.levelとSS.config.client.log.levelの値によって変更することができます。
ロギングには4つのレベルが使用可能で、none(0)から冗長(4)までの間で設定することができます。デフォルトのレベルは3です。

時には繰り返し呼ばれるサーバーへのリクエストに対してログを出力しないようにしたい時もあるでしょう。(e.g.位置情報の送信等) その場合は次のように'silent'オプションをSS.serverコマンドに追加します。

``` coffee-script
SS.server.user.updatePosition(latestPosition, {silent: true})
```

### Redisとの通信

Redisへのアクセスは自動的にグローバル変数Rを使うことでアクセスできるようになっています。

``` coffee-script
    R.set("string key", "string val")

    R.get("string key", (err, data) -> console.log(data))    # prints 'string val'
```

Redisホスト、ポート番号、データベース/keyspace インデックスは全てSS.config.redisパラメータによって設定可能です。
development/staging/productionそれぞれの環境別にデータを格納するためにSS.config.redis.db_indexの値を設定したくなるかもしれません。

SocketStreamが内部で使用するkeyやpub/subチャンネルのキーは全て先頭に'ss:'が付きます。ユーザーは任意のキーをアプリケーション内でで使うことができます。

[Redisの全コマンド一覧](http://redis.io/commands)


### データベースとの接続

DBとやりとりするためのフレームワークの開発は将来のリリースの中で重要な位置を占めていますが、現在はmongoDBとの接続のみをサポートしています。

/config/db.coffee (or .js) ファイルは起動時に自動的に読み込まれます。(存在する場合) そのため下記のようにデータベースの初期設定をこのファイルに書くことができます。

``` coffee-script
mongodb = require('mongodb')   # installed by NPM
Db = mongodb.Db
Connection = mongodb.Connection
Server = mongodb.Server
global.M = new Db('my_database_name', new Server('localhost', 27017))
M.open (err, client) -> console.error(err) if err?
```
これによって、グローバル変数M経由でmongoDBにアクセスできるようになります。

このファイルは対象の環境のコンフィグファイルが読み込まれた後にロードされるため、DB接続設定を/config/environments/develpment.coffeeに下記のように書くことができます。

``` coffee-script
exports.config =
  db:
    mongo:
      database:     "my_database_name"
      host:         "localhost"
      port:         27017
```

ここで定義した値を使って/config/db.coffeeの設定を行います。

``` coffee-script
config = SS.config.db.mongo
global.M = new Db(config.database, new Server(config.host, config.port))
```

CouchDBやMYSQL、その他のDBについてはテストをしていません。しかし設定の手順はこれと同じようになるはずです。


### ネームスペース (Client and Shared code)

JavaScriptベースのWebアプリというエキサイティングな世界における問題の一つとして、ファイルをどこに配置し、プロジェクトの進化に合わせてどのように構成していくかという問題があります。

SocketStreamの新しいアプローチは全てのクライアントと共有ファイルをグローバル変数SS.clientとSS.shareにて参照可能な'API tree'に対応付けるという方法です。
サーバーコードはそれらとは少し異なりますが、本質的には同じアプローチになります。(サーバーの場合SS.serverとなります)

このルールは単純です:'exports'が付いていない全てのオブジェクト、関数、変数は自動的にプライベートとなる。一旦exportすることでそれらはAPIツリーに追加され、同じ環境のあらゆるファイルからアクセスできるようになります。

たとえば、/app/client/navbar.coffeeというファイルを作成し、下記のコードを追加します。

``` coffee-script
areas = ['Home', 'Products', 'Contact Us']

exports.draw = ->
  areas.forEach (area) ->
    render(area)
    console.log(area + ' has been rendered')

render = (area) ->
  $('body').append("<li>#{area}</li>")
```
    
この場合、'draw'メソッドはパブリックとなり、SS.client.navbar.doraw()とすることで、クライアントコードやブラウザのコンソールのどこからでも呼び出せるようになります。'areas'変数と'render'関数は両方共プライベートなので、
グローバルの名前空間が汚染されることはありません。

複数のフォルダや深いオブジェクトツリーを使うことによるネストされたネームスペースもサポートしています。SocketStreamは起動時にネームスペースにて名前の衝突が起きていないかどうかチェックします。
開発チームはAPIツリーをSocketStreamの中でも特に気の利いた機能だと考えています。あなたの考えを教えてください。

**Tip** もしキーストロークを節約したい場合、SS.clientへのエイリアスを下記のように作ることもできます。

``` coffee-script
window.C = SS.client

C.navbar.draw()
```

### コードの共有

SocketStreamが持つ強力な機能の一つに、クライアントとサーバー間で同じJavaScript/CoffeeScriptコードを共有できることが挙げられます。もちろんコードをクライアントとサーバー両方に常にコピーすることもできますが、SocketStreamはより洗練された方法を提供します。

共有コードの書き方や、名前空間へのマッピングはクライアントコードと同じ方法で行われます。しかし共有コードはクライアントとサーバー両方の環境で動作するようにデザインされています。単純に新しいファイルを/app/sharedに追加し、
共有したい関数やプロパティオブジェクト、CoffeeScriptのクラスなどをexportするだけです。

たとえば/app/shared/calculalte.coffeeというファイルを作成し、下記のコードを貼り付けます。

``` coffee-script
exports.circumference = (radius = 1) ->
  2 * estimatePi() * radius

estimatePi = -> 355/113
```    

これによってSS.shared.calculalte.circumference(20)といった呼び出しがサーバーとクライアント両方のどこからでも実行できるようになります！/app/sharedは計算やフォーマット用のヘルパ、モデルを検証するコード等を配置するための場所です。共有コードの中でDOMやバックエンドのDB、もしくはNode.jsのライブラリなど特定の環境でのみ動作する処理は行わないでください。共有コードはサーバーとクライアント両方で動作する'ピュア'なコードである必要があります。

全ての共有コードは事前にロードされ、SS.shared APIツリーに追加されます。これらのAPIはサーバーとブラウザコンソール両方からいつでも調べることができます。APIツリー上にestimatePi()がないことに気がつかれるかもしれません。これはestimatePiをプライベート関数として定義したからです。(コード自体はクライアントへ転送されています。)

**警告** /app/shared内の全てのコードは初期接続時に圧縮され、クライアントへ送られます。プロプライエタリなソースやデータベース/ファイルシステムの呼び出しを含まないようにしてください。


### ヘルパー

ソケットストリームは複数のJavaScriptヘルパーメソッドによって構築されています。ヘルパーメソッドは新しいプロジェクトを作成した時に作られます。このコンセプトはRailsのActiveSupportによく似ています。

デフォルトのヘルパーはサーバー側のSocketStream全体で使われますが、クライアント、共有コード、サーバーコード側で使うこともでき、結果は同じになります。どこで実行するかを気にする必要はありません。

利用可能なヘルパを見るには/lib/client/3.helpers.jsを観てみてください。もしサードパーティのライブラリと競合していたり、単純にヘルパを使わないのであれば、ファイルを削除してしまっても問題ありません。


### セッション

SocketStreamはブラウザからサーバーへ最初の接続があった際にセッションを新しく作ります。クライアント側のセッションクッキーはRedisに格納されます。同じブラウザから再度アクセスがあった場合(もしくはブラウザがリフレッシュした場合)、
セッションは即座にReidsから取り出されます。

現在のセッションオブジェクトはgetSession関数をサーバーサイドで呼び出すことで取得することができます。

``` coffee-script
exports.actions =

  getInfo: (cb) ->
    @getSession (session) ->
      cb("This session was created at #{session.created_at}")
```

### ユーザーとモジュール化認証

ほとんと全てのWebアプリケーションはユーザーの認証機構を備えています。そのため開発チームは'カレントユーザー'の概念をSocketStreamのコアに組み込みました。これは開発者の人生を簡単にするだけでなく、正しいpubsubシステムや APIリクエストの認証、オンライン中のユーザーの追跡(下記セクションを参照してください)を行うために必須の機能となっています。

認証は完全にモジュール化され、簡単に実装できます。下記に示すのは/lib/server/custom_auth.coffeeに配置したカスタム認証モジュールの例です。

``` coffee-script
exports.authenticate = (params, cb) ->
  success = # do DB/third-party lookup
  if success
    cb({success: true, user_id: 21323, info: {username: 'joebloggs'}})
  else
    cb({success: false, info: {num_retries: 2}})
```

* クライアントから送られたパラメータが最初の引数に渡されていることに注目してください。通常は{username: 'something', password: 'secret'}といった形になりますが、バイオメトリックIDやiPhoneデバイスID、SSOトークンなどを含むこともできます。

* 二番目の引数はコールバック関数です。これには必ず 'status' 属性(boolean)と 'user_id' 属性(数もしくは文字列)を成功した場合に渡す必要があります。さらに残り試行回数などを追加のパラメータとしてオブジェクトに含め、クライアントに
送り返すこともできます。

このカスタム認証モジュールをあなたのアプリで使うには、/app/server内のコードで@getSessionを呼び出し、session.authenticateの最初の引数として作成したモジュールの名前を渡す必要があります。

``` coffee-script
exports.actions =

  authenticate: (params, cb) ->
    @session.authenticate 'custom_auth', params, (response) =>
      @session.setUserId(response.user_id) if response.success       # sets @session.user.id and initiates pub/sub
      cb(response)                                                   # sends additional info back to the client

  logout: (cb) ->
    @session.user.logout(cb)                                         # disconnects pub/sub and returns a new Session object
```

このモジュールアプローチは複数の方法でユーザーが認証を行うことを可能にします。将来的にはFacebookコネクトのような共通の認証サービスをサポートするかもしれません。

__重要__

認証を必要とする/app/server内のファイルでは下記のコードを先頭に配置してください。

``` coffee-script
exports.authenticate = true
```

これによってこのファイル内のメソッドが実行されるまえに、ユーザーのログインチェック、もしくはプロンプトが表示されるようになります。

一度ユーザーの認証が済むと、@getSessionでsessionを取得し、session.user_idを見ることで/app/serverコードのどこからでもユーザーIDにアクセスできるようになります。


### オンライン状態の追跡

一度ユーザーが認証を行いログインできるようになると、誰がオンライン状態なのか追跡したいと思うでしょう。特にリアルタイムチャットやソーシャルアプリを作る場合には。幸運にもその機能はフレームワークの中に組み込まれています。

ユーザーが認証に成功した際、対象ユーザーのIDはRedisに格納されます。オンライン状態のユーザー一覧はサーバーサイドにて下記のメソッドを呼び出すことで取得できます。

``` coffee-script
SS.users.online.now (data) -> console.log(data)
```

もしユーザーがログアウトした場合、即座にリストからそのユーザーは取り除かれます。しかしもしユーザーが単純にブラウザを閉じた場合や、回線が切断した場合はどうなるのでしょうか？

SocketStreamクライアントは超軽量な 'ハートビート' シグナルを、デフォルトで30秒ごとにサーバーに投げます。これによってユーザーがオンライン状態であることを確認できます。サーバープロセスは毎分毎にチェックを行い、応答がなかったユーザーをリストから取り除きます。全てのタイミングはSS.config.client.heartbeat_intervalとSS.config.users.onlineの値によって調節可能です。

注釈:'オンラインユーザー'の機能はオーバーヘッドが最小になるようにデフォルトでは設定されています。もしこの機能が不要なら、単純にapp configファイルにてSS.config.users.online.enabledの値にfalseを設定してください。


### さらにPub/Sub

上記で紹介したSS.publish.user()メソッドに加えて、まとめてユーザーにメッセージを送るためのコマンドが二つ用意されています。

全てのユーザーに通知を行うために(例えばサーバーメンテナンスによるシステムダウンを全員に通知する場合)、ブロードキャストメソッドを使います。

``` coffee-script
SS.publish.broadcast('flash', {type: 'notification', message: 'Notice: This service is going down in 10 minutes'})
```
    
複数の部屋をもつチャットアプリのように、時には特定の集団に向けてイベントを通知したいこともあるでしょう。SocketStreamにはプライベートチャンネルと呼ばれるまさにそのための機能があり、複数のサーバーに対して最小のオーバーヘッドで通知を行うことができます。


構文は通常の通知方法に似ています。チャンネル名(もしくはチャンネル名の配列)を最初の引数として指定してください。

``` coffee-script
SS.publish.channel(['disney', 'kids'], 'newMessage', {from: 'mickymouse', message: 'Has anyone seen Tom?'})
```
    
ユーザーは無制限のチャンネルを下記コマンドによって登録する事ができます(これらは/app/server内部でのみ動作します)

``` coffee-script
    @getSession (session) ->
      
      session.channel.subscribe('disney')        # note: multiple channel names can be passed as an array 
    
      session.channel.unsubscribe('kids')        # note: multiple channel names can be passed as an array 
    
      session.channel.list()                     # shows which channels the client is currently subscribed to
```

指定したチャンネル名が存在しない場合、チャンネルは自動的に作成されます。チャンネル名はJavaScriptで有効な任意のオブジェクトキー名を使うことができます。もしクライアントが切断し、別のサーバーインスタンスへ再接続した場合、同じセッションIDを持っている限り、自動的に同じチャンネルへの再登録が行われます。これらのコマンドを使うときはエラーを必ずキャッチするようにしてください。

**Notes**

SocketStream Pub/Subシステムは水平方向へのスケーラビリティと高スループットを念頭においてデザインされました。将来クラスタリングが可能になった時、'ブロードキャスト'と'チャンネル'コマンドは自動的は複数のSocketStreamサーバーに対してロードバランシングされるでしょう。

注意すべき点として、メッセージは保存されたりログに残らないことが挙げられます。もしclient/userがオフラインの場合、メッセージはキューに残ることなく単純に失われます。もしチャットアプリを作るのならメッセージを送る前に、それをデータベースかメッセージングサーバーに格納することをお勧めします。


### HTTP API

HTTP APIは全てのサーバーサイドのアクションを、従来のHTTPもしくはHTTPSリクエストベースのインタフェースでアクセスできるようにします。

HTTP APIはデフォルトで有効になっており、下記のコンフィグ変数にて変更することができます。

``` coffee-script
SS.config.api.enabled            Boolean       default: true         # Enables/disables the HTTP API
SS.config.api.prefix             String        default: 'api'        # Sets the URL prefix e.g. http://mysite.com/api
```

HTTP APIはBasic認証もサポートしています。それによってsession.user_idを使うメソッドにアクセスできるようになります。このオプションを使いたい場合、SS.config.api.https_onlyオプションにtrueを設定してパスワードが平文のまま送信されないようにすることをお勧めします。

``` coffee-script    
exports.config = 
  api: 
    auth: 
      basic: 
        module_name: "custom_auth"
```

'exports.authenticate = true' を設定することでサーバーはそのファイルへのアクセスにユーザー名とパスワードを要求するようになりますが、HTTP APIの場合、認証にどのモジュールを使うのか設定する必要があります。SS.config.api.auth.basic.module_name変数をコンフィグファイルに配置してください。

注釈:Basic認証は'username'と'password'パラメータをexports.authenticate関数に渡します。


### 回線切断時の対応

websocketと'flashsocket'トンネルは障害に対して驚くほど柔軟に対応しますが、開発者は常に接続が失敗する可能性を考える必要があります。特にモバイル機器の回線は不安定です。

**クライアントサイド**

SocketStreamクライアントにて利用可能な(Socket.IOの機能です) 'disconnect' イベントと 'connect' イベントに関数を登録することをおすすめします。例えば

``` coffee-script
SS.socket.on('disconnect', -> alert('Connection Down'))

SS.socket.on('connect', -> alert('Connection Up'))
```

これらのイベントはアプリの中でオンライン/オフラインのアイコンを切り替えたり、より良い方法としてスクリーンを暗くして'再接続中です...'とメッセージを表示するために使うことができます。

**サーバーサイド**

SocketStreamは自動的にクライアントが切断(タブが閉じられる等で)されたことを検知できます。その際にユーザーをログアウトやデータベースのクリーン、メッセージのブロードキャストを行いたいと思うでしょう。ユーザーが最初にアプリに接続する際に実行されるメソッド、SS.server.app.init()に下記のイベントハンドラを登録することをお勧めします。

``` coffee-script
exports.actions =

  init: (cb) ->
    @getSession (session) ->
      session.on 'disconnect', (disconnected_session) ->
        console.log "User ID #{disconnected_session.user_id} has just logged out!"
        disconnected_session.user.logout()
```

**Note**

現時点ではオフライン時にサーバーへとリクエストが送られた場合、リクエストはブラウザ内でキューに格納され、再接続した際に実行されます。近い内にタイムクリティカルなリクエストに対して「株取引のために必須」といったマークがつけられるようになるでしょう。


### カスタムHTTPハンドラ/ミドルウェアの使用

開発チームはまだこのアイディアを完全に探求していませんが、現在全てのHTTPリクエストをあなた自身のミドルウェアへ送ることができます。これによってリクエストオブジェクトを変更したり、さらにURL、ユーザーエージェント、リクエストパラメータに応じてヘッダとコンテンツを独自に処理できるようになります。

これは非常に強力な機能です。HTTPリクエストが到着した時にNodeは最初にこれを呼びだすため、完全に柔軟で無駄の無いNode.jsアプリを作ることができます。

将来この機能を使うときは/config/http.coffeeファイル内のコメントを見てみてください。ミドルウェアの例として、下記の内容を持つmy_middleware.coffeeというファイルを/lib/server内に置くことができます。

``` coffee-script
exports.call = (request, response, next) ->

  # Log the User Agent of each incoming request
  console.log 'User Agent is:', request.headers['user-agent']
  
  # All middleware must end with next() unless response is being served/terminated here
  next()
```

### 互換性のあるブラウザ

デフォルトではSocketStreamはネイティブwebsocket(利用可能なら)か 'flashsockets' を使って全てのブラウザにリアルタイムにコンテンツを提供しようとします。

flashsocketはオーバーヘッドや初期接続レイテンシが存在するため完全とは言えません。そのためStrictモードを使いたいと思うかもしれません。

``` coffee-script
SS.config.browser_check.strict = true
```
    
一度このオプションがセットされるとネイティブなwebsocketをサポートしているブラウザ(現在Chrome 4とSafari5以上)のみがアプリと通信できるようになります。
それ以外のブラウザでアクセスした場合、/static/incompatible_browsers/index.htmlの内容が表示されます。このファイルは自由にカスタマイズ可能です。

将来的には互換ブラウザを検出するテストの精度向上と、二重の防衛線としてSocketStreamクライアントでのFlashサポートの向上を行う予定です。

注釈:HTTP APIリクエストの提供はブラウザの互換性がチェックされる前に行われます。そのためこれらの設定は影響を与えません。


### セキュリティ

SocketStreamはどれくらいセキュアでしょうか？正直なところ、開発チームにはわかりません。Node.jsからSocketStreamクライアントまでのスタック全体は新しく、製品としての準備が全てできているとは言えません。現時点ではファイアウォールの内側でSocketStreamの運用をすることをお勧めします。

もちろん冒険してみたいならSocketStreamによるWebサイトを公開することもできます。私たちがwww.socketstream.orgにて公開(予定)しているように。重要なデータはサーバーに置かないようにし、なにかあった場合はすぐにレストアできるようにすべきです。

もしあなたが攻撃されたり、ソースコードの中に脆弱性を見つけた場合は私たちに教えてください。非常に助かります。そうすることによってSocketStreamによるWebサイトの公開が安全に行える日が近づきます。


__XSS攻撃__

クイックリマインダ:SocketStreamは他のWebフレームワークと同様にXSS攻撃を受ける可能性があります。インプットステージ(/app/server内のコード)とクライアント側でスクリーンにUGCを表示するまえに悪意のあるUGCをフィルタリングすることをお勧めします。将来的には 'helpers' にフィルタリングの機能を含める予定です。

ユーザーが投稿したリンクの最後に 'SS.server'内のメソッドをwhileループの中でひたすら呼びつづけるコードを埋め込むのはとても簡単にできます。これが実行されると素敵なことになるでしょう・・・


__レート制限とDDOS防御__

SocketStreamは特定のクライアントが一秒に15回以上websocketの接続を行うとしていることを検知することで、DDOS攻撃に対して防御する機能を持ちます。(回数はSS.config.limitter.websockets.rpsにて設定可能です。)

これが発生した場合、攻撃しているクライアントがコンソールに表示され、対象のクライアントからの全ての連続したリクエストは無視されます。この機能は我々が実際の環境で実験中のため現在はオフになっていますが、SS.config.limitter.enabledの値をtrueにすることで有効にすることができます。


### HTTPS / TLS (SSL) 
もし上記のセキュリティセクションを読み、SocketStreampアプリをインターネットに公開することを決めたのなら(VPNの内側ではなく)HTTPSはあったら良い程度の機能ではありません。必須の機能です。

その理由は二つ挙げられます。

1. HTTPプロキシー、プロキシは特にモバイル通信会社から使われ、HTTPリクエストを改変します。その改変によってwebsocketの初期化は妨害されます。HTTPS/TLSは通信の内容をだけではなくヘッダも暗号化し、3G回線上のモバイルSafariからでも(iPadとiPhone)websocketsが期待通りに動くことを保証します。

2. [FireSheep](http://en.wikipedia.org/wiki/Firesheep)を覚えていますか？インターネット上に公開するSocketStreamアプリのデフォルトをHTTPSにすることでこの問題にけりをつけましょう。

良いニュースはSocketStreamでHTTPSを使うのは簡単だということです。OpenSSLサポートを有効にして./configureとNode.jsのコンパイルを行っていることを確認してください。もしOpenSSLライブラリが未インストールなら次のコマンドでインストールすることができます(Ubuntuの場合)

    sudo apt-get install libssl-dev openssl  (ヒント: これを行った後に pkg-config をインストール/起動する必要があるかもしれません)

一度NodeがHTTPS/TLSをサポートしたら、statingかproduction環境でSS.config.https.enabled = trueとすることでHTTPS/TLSが有効になります。デフォルトではSocketStreamはHTTPSサーバーをポート443で立ち上げようとするため、起動にはsudoコマンドを使う必要があるでしょう。

SocketStreamは自己署名付きSSL証明書を持っています。これはコマーシャル証明書が見つからない場合にデフォルトでロードされます。これはテスト/デバッグを行うときに役立ちます。しかし、自己署名付き証明書をサポートしていないブラウザでwebsocketを使う場合、問題が発生するかもしれません。


**デプロイ**

アプリを公開する準備ができたら、正当なSSL証明書が必要になるでしょう。開発チームはwww.rapidssl.com](www.rapidssl.com) を好んで使っています。何故ならここは他の有名なプロバイダが行っていないモバイルバージョンのSafari(iPadとiPhone)をサポートしているからです。

商用のSSL証明書を得るには下記のコマンドをプロジェクトのルートディレクトリで実行してください。

    cd config/ssl_certs

    openssl genrsa -out site.key.pem 2048
    
    openssl req -new -key site.key.pem -out site.request.csr
    
注釈:コモンネームの入力には注意を払ってください。これはあなたのWebサイトのフルドメイン(www.を含む)でなければいけません。
    
site.request.csrファイルの内容を認証局に送ってください。ファイルと交換で/config/ssl_certs/site.cert.pemファイルとして証明書が送られます。全てのブラウザで証明書の検証が行えるように'中間証明書'も取得するようにしてください。

一度全てのファイルが揃うとSocketStreamはその証明書を自己署名のテスト証明書の代わりに使い、サーバーの起動時にそのことを通知します。


**strayリクエストのリダイレクト**

一度HTTPSが有効になると、証明書の中で 'Common Name' としてリストに載っているドメインに行くことが非常に重要になります。これは基本的にあなたのサイトの'www.'バージョンです。SS.config.https.domainにあなたのサイトのFQDN(www.yourdomain.com)を設定することでSocketStreamは自動的に http://yourdomain.com へのあらゆるリクエストを https://www.yourdomain.com にリダイレクトします。そうすることで、サイトの訪問者は奇妙なセキュリティ警告を見なくて済むようになります。

さらにデフォルトではセカンダリHTTPサーバーをポート番号80で立ち上げ、http:// へ送られたAPIではないトラフィックをhttps://へ転送します。これらの動作が不要ならオフにすることも可能です。(SS.config.httpを見てください。)


**複数の証明書の使用**

最後に、複数のSSL証明書を/config/ssl_certsにインストールすることができ、SS.config.https_cert_nameによってSocketStreamがどれを使うのか選択することができます。
デフォルトではこの値は'site'になっています。そのためsite.key.pem、 site.cert_pemにしていたわけです。


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
