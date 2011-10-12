<!--
### Internal RPC Spec
-->
### 内部RPC仕様

<!--
_This is basic documentation for SocketStream core developers_
-->
_SocketStream のコア開発者向け基本ドキュメントです_

<!--
At present RPC calls between front and back end SocketStream servers are in JSON format for maximum flexibility as we experiment with new ideas. Once things settle down a little we will be able to test and benchmark alternative formats for even higher throughput.
-->
フロントエンドとバックエンドサーバー間の RPC 呼び出しは我々の新しいアイディアを取り入れやすくするため、柔軟性を重視して JSON フォーマットになっています。 開発が落ち着けば、高スループットを出すために別のフォーマットをテストし、ベンチマークを測ることもできるでしょう。

<!--
#### The request
-->
#### リクエスト

<!--
Requests are composed of the following params:
-->
リクエストは下記のパラメータから構成されます:
       
<!--
    **version**      Mandatory. Back end servers will silently drop messages unless they match the same RPC version number (allowing upgrades to be staggered)
    **responder**    Mandatory. Contains the name of the backend responder which will be invoked
    **origin**       Mandatory. Currently either 'socketio' or 'api'
    **id**           Optional. Used when sending a request which requires a response. The 'id' must be passed through to the response
-->
★     **version**      必須です。異なるバージョンのメッセージを受け取った場合、バックエンドサーバーはそれを無視します（アップグレードを順次行うことができます）
   **responder**     必須です。呼び出されるバックエンドレスポンダの名前を格納します
   **origin**        必須です。現在は 'socketio' もしくは 'api' がその値になります
★   **id**            任意です。レスポンスを要求するリクエストを送信する際に使います。レスポンスを通じて 'id' を送らなければならないでしょう

<!--
And in addition for messages to /app/server methods:
-->
/app/server のメソッドに送るメッセージは更に追加のパラメータを持ちます:

<!--
    **method**       Optional. Tells the message handler which command to invoke
    **params**       Optional. Any arguments send to the method, as an array
    **session**      Optional. Sent only if the transport supports persistent sessions. Should be an object containing id, user_id, channel subscriptions and more
    **post**         Optional. Post data, if present, as submitted over the HTTP API
-->
    **method**       任意です。メッセージハンドラに呼び出すコマンドを伝えます
    **params**       任意です。メソッドに送られる引数を保持する配列です
    **session**      任意です。転送手段が永続セッションをサポートしている場合のみ送られます。これは id、user_id、channel subscription 等を保持するオブジェクトでなければいけません
    **post**         任意です。HTTP API 経由で送られた場合にポストされたデータが入ります

<!--
Hence a typical request originating from a front end server via Socket.IO looks like this:
-->
フロントエンドサーバーからSOcket.IO 経由で送られる標準的なリクエストは下記のようになります:

<!--
    { 
      id: 1,
      session: {id: 'lBxsWeoQDPZjl6Ylb2P5XeSipfSkcw1N', user_id: 'joebloggs', attributes: []}
      origin: 'socketio',
      method: 'app.square',
      params: [5]
    }
-->
    { 
      id: 1,
      session: {id: 'lBxsWeoQDPZjl6Ylb2P5XeSipfSkcw1N', user_id: 'joebloggs', attributes: []}
      origin: 'socketio',
      method: 'app.square',
      params: [5]
    }

HTTP API によって送られるリクエストは下記のようになります:

<!--
    { 
      id: 2,
      origin: 'api',
      post: 'something=nothing'
    }
-->

<!--
#### The response
-->
#### レスポンス

<!--
When successful:
-->
成功した場合:

<!--
    { 
      id: 1,
      result: 54
    }
-->
    { 
      id: 1,
      result: 54
    }

<!--
Should you modify any session params:
-->
なんらかのセッションパラメータを変更する場合:

<!--
    { 
      id: 1,
      result: 54
      session_updates: {user_id: 'fred'}
    }
-->

<!--
When there is an error:
-->
エラーが起きた場合:

<!--
    { 
      id: 1,
      error: {code: 'MISSING_PARAMS', message: 'Some params are missing'}
    }
-->
    { 
      id: 1,
      error: {code: 'MISSING_PARAMS', message: 'パラメータが足りません'}
    }


<!--
#### Why JSON?

Other serialization formats were tried but initial tests show none or little performance improvement using Msgpack and problems with recursive serialization of nested objects when using various BSON implementations. So for now JSON is a good choice - especially as it doesn't require any C libraries to be compiled.

SocketStream developers: Feel free to experiment and benchmark other message formats but bear in mind the need to recursively serialize nested objects.
-->
### 何故 JSON なのか？

他のシリアライゼーションフォーマットも試して見ましたが、Msgpack を使うことによるパフォーマンスの向上はほとんどなく、BSON といったフォーマットを使う場合には入れ子になったオブジェクトをシリアル化する際に問題がありました。そういった理由や、またコンパイルするためにCライブラリを必要としないという点も JSON を選択する理由となっています。
