### モジュール化されたユーザ認証

ユーザのログイン・ログアウト機能を必要とする Webアプリケーションは多いでしょう。そのため私たちは 'カレントユーザ' という概念を SocketStream に取り入れました。これは、開発をやりやすくさせるだけでなく、ちゃんとした pub/subシステムの開発、APIリクエストの認証、オンラインユーザのトラッキング>（後述するセクションを参照してください）をするために欠かせないものです。

認証はモジュール化されているのでサクッと実装できます。たとえば、お手製の認証モジュールを /lib/server/custom_auth.coffee につくってみましょう。

``` coffee-script
exports.authenticate = (params, cb) ->
  success = # DB アクセスなど何かやる
  if success
    cb({success: true, user_id: 21323, info: {username: 'joebloggs'}})
  else
    cb({success: false, info: {num_retries: 2}})
```

* クライアントから送られるパラメータが第一引数に渡されていることに注目してください。一般的なパラメータは `{username: 'something', password: 'secret'}` といった値ですが、バイオメトリックID・iPhoneデバイスID・SSOトークンなど他のパラメータを追加できます。


* 第二引数はコールバック関数です。コールバック関数には必ず '認証の可否' を表す値（下記の例では 'success' 属性に設定）と 'user_id' パラメータ（数もしくは文字列）を渡す必要があります（'user_id' パラメータは認証が成功した場合のみ）。さらに、残りログイン試行回数など他のパラメータを追加してクライアントに送り返せます。

つくった認証モジュールを使うには、/app/server 内のコードで `@session.authenticate` を呼び出し、第一引数にモジュール名を渡します。

``` coffee-script
exports.actions =

  authenticate: (params, cb) ->
    @session.authenticate 'custom_auth', params, (response) =>
      @session.setUserId(response.user_id) if response.success      # session.user.id をセットして pub/sub を開始する
      cb(response)                                                  # 追加情報をクライアントに送る

  logout: (cb) ->
    @session.user.logout(cb)                                        # pub/sub を切断してまっさらな Session オブジェクトを返す
```

モジュール化アプローチによって、複数の方法でユーザ認証が行えます。今後、Facebook コネクトのような HTTP でのやりとりを必要とする共通認証サービスをサポートする予定です。

ユーザーの認証が済むと、/app/server 内のコードから `@sessionn.user_id` 経由でユーザIDにアクセスすることができます。
