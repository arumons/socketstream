### ディレクトリ構造

下記のディレクトリは `socketstream new` コマンドを実行することで生成できます：

#### /app/client
* /app/client ディレクトリ配下の全ファイルはクライアントに送られます。
* CoffeeScript ファイルは自動的に JavaScript ファイルに変換されます
* 使いたい JavaScript ライブラリ（例：jQuery UI）は /lib/client に配置してください
* SS.client.app.init() 関数は、websocket コネクションの確立時に自動的に一度だけ呼び出されます
* 従って、/app/client/app.coffee（もしくは app.js）ファイルは必須です
* /app/client 配下にディレクトリを作成できます。詳しくは、名前空間セクションを参照してください。

#### /app/server
* このディレクトリ内の全てのファイルはクライアントから呼び出し可能な関数を公開できます（サーバーサイドコードセクションを見てください）
* 例えばクライアント側から app.init に引数として 25 を渡して呼び出すには `SS.server.app.init(25)` と書きます
* 全てのメソッドはオプショナルな HTTP API としてアクセス可能になります（例：/api/app/square.json?5）
* すべてのメソッドは事前にロードされ、コンソールや他のサーバーサイドのファイルから `SS.server` 経由でアクセスできます
* 最後の引数は常にコールバック（cb）です
* すべてのパブリックなメソッドは 'exports.actions' のプロパティとして定義されます。プライベートなメソッドはそのスコープの外側に配置されます。定義は 'methodname = (params) ->' から始まります。
* サーバー側のファイルはネストできます。例えば `SS.server.users.online.yesterday()` と書けば、/app/server/users/online.coffee に定義された 'yesterday' メソッドが呼び出されます
* 同じファイルの中で名前空間をわけるためにオブジェクトをネストすることもできます
* @session でユーザのセッションにアクセスできます
* @request で RPC 呼び出しを考慮したメタデータにアクセスできます（もし存在するなら HTTP POST データも含んでいます）

#### /app/shared
* '共有コード' セクションを見てください

#### /app/css
* 通常の.cssファイルの他に .style([Stylus](http://learnboost.github.com/stylus/))、.less ([Less](http://lesscss.org/))ファイルをサポートしています
* まず "app" の後に選択したフォーマットに応じた拡張子名をつけたファイルが必須となります（例:app.style）
* 外部 Stylus もしくは Less ファイルは @import 'name_of_file' とすることで app.* に取り込むことができます。ファイルをネストすることもできます
* 静的な .css ファイルでは @import は使えません。代わりに Stylus か Less を使ってください
* CSSライブラリ（例: normalize.css や jQuery UI など） を使いたい場合、それらを /lib/css に配置するか、ホスティングされている CDNファイルへのリンクを /app/views/app/jade に書いてください
* Stylus & Less ファイルは自動的にコンパイルされ、developmentモードの場合、そのまま送られます。staging もしくは production モードの場合、プリコンパイル、圧縮、キャッシュされます

#### /app/views
* /app/views/app.jade もしくは /app/views/app.html は必須です。このファイルにはアプリを初期表示するための静的HTMLを書いてください
* [Jade](http://jade-lang.com/)（HAML に似ています）フォーマットを使えます（正しい HTML構文が保証されるため使用をオススメします）
* HTML の HEADタグには Jade では '!= SocketStream' を、プレーンHTML では '<SocketStream>' を含めます。このヘルパーは環境（SS_ENV で指定します）ごとにライブラリをただしく読み込みます
* Jade と HTML 両方で jQuery template（Rails の partial に似ています）を使って別ファイルにわけた HTML を簡単に取り込めます。例えば /app/views/people/customers/info.jade に書いた部分テンプレートは $("#people-customers-info").tmpl(myData) としてアクセスできます
* ビューとテンプレートは自動的にコンパイルされ、developmentモードの場合、そのまま送られます。staging や production モードの場合、プリコンパイル、圧縮、キャッシュされます

#### /lib
* /lib/client や /lib/css 配下のファイルを変更すると、クライアントアセットとして自動的に再コンパイル、パッキング、ミニファイされます
* /lib/server に配置したモジュールは /app/server ファイルにて SS.require('my_module.coffee')とすることで簡単に読み込めます
* これらのディレクトリに新しくファイルを追加してもサーバーを再起動するまでは認識されません。開発チームは現在この問題を修正中です
* ライブラリ名の先頭に数字をつけることで、ライブラリの読み込み順を簡単に指定できます（例: 1.jquery.js, 2.jquery-ui.js） 
* クライアント側の JSファイルは、ファイル名に '.min' が含まれていないと [UglifyJS](https://github.com/mishoo/UglifyJS) によって自動的にミニファイされます

#### /public
* 静的ファイルを配置してください（例: /public/images, robots.txt など）
* /index.html と /public/assetsディレクトリは SocketStream によって管理されるので変更を加えないでください
