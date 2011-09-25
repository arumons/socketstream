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

CouchDB や MYSQL 等、その他の DB についてはテストをしていませんが、他の人達が上記の方法でデータベースを SocketStream と接続できていることを把握しています。
