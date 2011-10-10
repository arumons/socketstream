### サーバーサイドコード

/app/server ディレクトリ内に配置された全てのファイルは__オプショナルに__ websockets 経由でアクセス可能な`SS.server` パブリックAPIや、HTTP API（オプションで有効にしている場合）として公開するかどうか選択することができます。公開された全てのアクションは最後に引数としてコールバック関数を受け取る__必要があります__：

``` coffee-script
exports.actions =

  whatAmI: (cb) ->
    cb "公開アクションです。 コールバックが必要になります"


whatAmI: ->
  return "プライベートメソッドです。 コールバックは必要ではありません。"
```

#### 複数の引数を送る

SocketStream 0.2.0 では /app/server メソッドに複数の引数を送ることができますが、これは HTTP API との互換性を失います。互換性を保ちたい場合は複数の値をオブジェクトに詰めて、最初の引数として渡すようにしてください（HTTP API ドキュメントにある例を見てください）。

#### プライベートコードをファイル間で共有する

/app/server ファイル間でプライベートなコードを共有したくなるかもしれません。その時はそれらのモジュールを /lib/server に配置し、次のようにそのモジュールを参照してください：

``` coffee-script
my_module = require(SS.root + '/lib/server/my_module.coffee')
```

上記のコードは冗長なので、私たちはラッパーを用意しました：

``` coffee-script
my_module = SS.require('my_module.coffee')
```
