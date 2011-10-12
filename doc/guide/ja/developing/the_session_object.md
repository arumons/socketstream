### @session オブジェクト

ブラウザがサーバーへ最初に接続したタイミングで SocketStream は新しいセッションを作成し、クライアント側ではセッション用のクッキーが保存され、その詳細がセッションストアに保存されます。同じブラウザから再度アクセスがあると（もしくはブラウザがリフレッシュした場合）、セッションは Redis から即座に取り出されます。

セッションの詳細はサーバーサイドにて @session オブジェクトを使うことでアクセスできます。

``` coffee-script
exports.actions =

  getInfo: (cb) ->
    cb "このセッションは #{@session.created_at} に作られました"
```

注釈：別のコールバックから @session にアクセスしたい時は、-> の代わりに => を使うようにしてください。


#### カスタムデータの保存

@session.attributes の中に同時のデータを持たせることができます。

``` coffee-script
exports.actions =

  set: (size, cb) ->
    if size.length < 100
      @session.attributes = {size: size, type: 'Tシャツ'}
      @session.save cb
    else
      cb false
  
  getSize: (cb) ->
    cb @session.attributes.size

```

重要：@session は JSON.stringify() 経由でフロントエンドからバックエンドへとリクエストの度に送られます。データの量はなるべく小さくなるようにしてください。
また session.save() を呼ぶ前に送られてきたデータのチェックを忘れないようにしてください。

#### セッションデータの格納場所

セッションデータは全て内部メモリ（プロジェクトを作成した時点ではこれがデフォルトです）か Redis（あなたのアプリをホストする場合はこちらが必要になるでしょう）のどちらかに保存されます。キャッシュはユーザーが接続中のフロントエンドサーバーに保存され、バックエンドサーバーへの内部 RPC 呼び出しに渡されます。これによってリクエストの度に Redis へのアクセスが発生することを防げます。
