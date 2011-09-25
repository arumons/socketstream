### Redisとの通信

Redis は、自動的にサーバサイドのどこからでもグローバル変数R にてアクセスできるようになっています。

``` coffee-script
    R.set("string key", "string val")

    R.get("string key", (err, data) -> console.log(data))    # 'string val' を出力する
```

Redis のホスト、ポート番号、データベース／キースペースのインデックスは SS.config.redis によって設定できます。development／staging／production ごとにデータを格納するために SS.config.redis.db_index の値を設定したくなるかもしれません。

key や pub/subチャンネルなど、SocketStream が内部で使用する全てのキーの先頭には 'ss:' が付きます。それ以外のダブらないキーをアプリケーション内で使えます。

[Redis の全コマンド一覧](http://redis.io/commands)
