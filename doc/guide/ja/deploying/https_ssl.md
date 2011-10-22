### HTTPS / TLS (SSL)

上記のセキュリティのセクションを読んで SocketStreamアプリを（VPNの内側ではなく）インターネットに公開するのなら、HTTPS は「あったらいいのになぁ」という程度のものではありません。必須ですね。

理由は二つあります。

1. 携帯の通信会社がよく使う HTTPプロキシーはリクエストを改変します。それによって websocket の初期化はたびたび妨げられます。そこで HTTPS/TLS を使うことで通信の内容だけでなくヘッダも暗号化されるので、3G回線上のモバイルSafari（iPad や iPhone）からでも websocket がちゃんと動くようになるでしょう。

2. [FireSheep](http://en.wikipedia.org/wiki/Firesheep) をご存知ですか？　セッションハイジャックの問題は、インターネット上に公開する SocketStreamアプリのデフォルトを HTTPS にすることでケリをつけましょう。

SocketStream で HTTPS は簡単につかえます。./configure を実行して、OpenSSL サポート付きの Node.js をコンパイルするだけです。もし OpenSSL ライブラリのインストールがまだなら次のコマンドでインストールできます（Ubuntuの場合）

    sudo apt-get install libssl-dev openssl （ヒント: 実行後に pkg-config をインストール／起動が必要かもしれません）

Node が HTTPS/TLS をサポートするようにさせたら、stating または production 環境で `SS.config.https.enabled = true` と設定することで HTTPS/TLS を有効にできます。SocketStream はデフォルトで HTTPSサーバーを 443番ポートで立ち上げようとするため、起動には 'sudo'コマンドが必要になるでしょう。

認証されたSSL証明書が見つからない場合は SocketStream に付属する自己署名証明書がデフォルトでロードされます。テストやデバッグには役立ちますが、自己署名証明書をサポートしていないブラウザで websocket を使うときには問題が発生するかもしれません。


#### デプロイ

アプリを公開する準備ができたら、認証済みの SSL証明書が必要になるでしょう。私たちは [www.rapidssl.com](www.rapidssl.com) が気に入っています。他の名だたるプロバイダがやっていないモバイルバージョンの Safari（iPad と iPhone）をサポートしているからです。

SSL証明書を申請するにはプロジェクトのルートディレクトリで下記のコマンドを実行してください。

    cd config/ssl_certs

    openssl genrsa -out site.key.pem 2048

    openssl req -new -key site.key.pem -out site.request.csr

注釈: Common Name は注意して入力してください。Common Name は、あなたの Webサイトのフルドメイン（www.を含む）でなければいけません。

site.request.csr ファイルを認証局に送ると証明書が手に入ります。その証明書を /config/ssl_certs/site.cert.pem に配置してください。また、すべてのブラウザでただしく検証できるように '中間証明書' を /config/ssl_certs/site.ca.pem に配置してください。

それらのファイルがすべて揃うと SocketStream は自己署名証明書のかわりに認証された証明書を使うようになり、サーバの起動時にコンソールへ通知されます。


#### strayリクエストのリダイレクト

HTTPS が使えるようになってからは、証明書に記載されている 'Common Name'（'www.' を含むフルドメイン）にサイト訪問者がアクセスできるようにしなければなりませんね。`SS.config.https.domain` にサイトのFQDN（例: www.yourdomain.com ）を設定することで、SocketStream は http://yourdomain.com へのリクエストを https://www.yourdomain.com へ自動的にリダイレクトします。これによって訪問者は残念なセキュリティ警告を見ずに済みます。

デフォルトではさらにセカンダリHTTPサーバーを80番ポートで立ち上げ、APIからではない http:// へのリクエストを https:// へ転送します。リダイレクトが不要ならオフにできます（`SS.config.http` を参照）。


#### 複数の証明書を使いわける

複数の証明書を使いわけたいなら /config/ssl_certs にそれぞれを配置し、`SS.config.https_cert_name` を設定することで SocketStream が使う証明書を指定できます。
デフォルトではこの値は 'site' になっています。そのため前述した説明ではファイル名を site.key.pem と site.cert_pem にしていました。
