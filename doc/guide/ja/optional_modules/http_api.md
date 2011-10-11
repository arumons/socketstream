<!--
### HTTP API

_Module status: Enabled by default. Disable with `SS.config.api.enabled = false`_
-->

### HTTP API

_Module status: デフォルトで有効です。`SS.config.api.enabled = false` で無効にできます。_

<!--
The HTTP API allows all server-side actions to be accessed over a traditional, high-speed, HTTP or HTTPS request-based interface.
-->

HTTP API は、従来以上に高速で、HTTP や HTTPS といったリクエストベースのインタフェースでアクセスすることをすべてのサーバー側アクションを許可します。 

<!--
For example a method invoked as `SS.server.chat.members.onlineNow()` over the websocket can also be accessed as `http://localhost:3000/api/chat/members/onlineNow` via the HTTP API.
-->

例えば、`SS.server.chat.members.onlineNow()` で起動されたメソッドはさらに、 websocket 上の HTTP API 経由で`http://localhost:3000/api/chat/members/onlineNow` にアクセスすることもできます。

<!--
#### Passing values
-->

#### 値渡し

<!--
You can pass values to your server-side methods as part of the query string:

``` coffee-script
# http://localhost:3000/api/app/square.json?5 will call
square(5) # in /app/server/app.coffee
```
-->

クエリ文字列の一部としてサーバー側メソッドに値を渡すことができます。:

``` coffee-script
# http://localhost:3000/api/app/square.json?5 will call
square(5) # in /app/server/app.coffee
```

<!--
You may also pass multiple values at once by separating each one with `&`, but note these are passed as an object to the first argument of your method.
-->

`&` で区切って一度に多数の値を渡しても良いですが、メソッドの最初の引数にオブジェクトとして渡されることに注意が必要です。

<!--
Hence if the HTTP API is something you wish to use, you should always ensure your methods expect multiple values to be passed to the first argument as an object (as was the case in SocketStream 0.1):

``` coffee-script
# http://localhost:3000/api/app/updateCart.json?total=126.23&items=5 will call
updateCart({total: 126.23, items: 5}) # in /app/server/app.coffee
```
-->

このように HTTP API を利用しようとしたとき、あなたは常にメソッドがオブジェクトとして最初の引数で多数の値を受け取れるよう保障すべきです ( SocketStream 0.1 の場合)。:

``` coffee-script
# http://localhost:3000/api/app/updateCart.json?total=126.23&items=5 will call
updateCart({total: 126.23, items: 5}) # in /app/server/app.coffee
```
<!--
#### HTTP POST data
-->

#### HTTP POST データ

<!--
On rare occasions you may wish to POST data to a method via the HTTP API. If you do, you may access it with `@request.post.raw` from within the server-side method. Note : Posting data does not affect the way a method is called or the arguments it receives in anyway.
-->

ごく稀に、HTTP API 経由でメソッドへ データを POST したい場合があります。もしする場合は、サーバー側メソッドの中から `@request.post.raw` でアクセスできます。 注 : 投稿しているデータはどんな方法でメソッドが呼ばれたかや引数に渡されたかなどに影響しません。

<!--
#### Authentication
-->

<!--
The HTTP API will support various forms of authentication in future versions of SocketStream.
-->

HTTP API は SocketStream の将来のバージョンでさまざまな認証形式をサポートする予定です。

<!--
#### Config Options
-->

#### オプション構成

<!--
By default the HTTP API answers all requests to `/api`, but this URL prefix can be changed with the `SS.config.api.prefix` config parameter if you prefer.
-->

既定では HTTP API は `/api` へのリクエストにはすべて応答しますが、お好みでこの URL 接頭辞は `SS.config.api.prefix` 構成パラメータで変更できます。

<!--
You may also set `SS.config.api.https_only = true` if you have HTTPS enabled and want to ensure API requests are only served over SSL.
-->

API リクエストが SSL 上に提供されることを保障したい場合は `SS.config.api.https_only = true` を設定すると、HTTPS が有効になります。
