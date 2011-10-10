### @request オブジェクト

SocketStream 0.2 で @request オブジェクトを導入しました。これは /app/server メソッドの呼び出しに関連する全てのメタデータを保持しています。メソッドの呼び出しが websockets 経由でも HTTP API 経由でもメインのパラメータの値は常に同じですが、@request オブジェクトの内容はメソッドの呼び出し方法によって変化します。

例えば、 /app/server メソッドを webocket 経由で呼び出した場合、@request オブジェクトの内容は下記のようになります：

    {
      id: 45,
      origin: 'socketio'
    }

一方で、HTTP API 経由でメソッドを呼び出すと@request オブジェクトの内容は下記のようになるでしょう：

    {
      id: 46,
      origin: 'httpapi'
    }

0.2 ではHTTP API メソッドへ POST 経由でデータを送ることもできます。送られたデータは 下記のように @request オブジェクトから取り出すことができます。

``` coffee-script
exports.actions =

  getPostData: (cb) ->
    if @request.post
      cb "ポストされたデータです: #{@request.post.raw}"
    else
      cb "ポストされたデータはありません"
```
