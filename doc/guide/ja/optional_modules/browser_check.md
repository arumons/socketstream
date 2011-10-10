### ブラウザチェック - 非互換ブラウザへの対処

_Module status: デフォルトでは無効になっています。`SS.config.brower_check.enabled = true` とすることで有効になります_

SocketStream はデフォルトで全てのブラウザに対し、ネイティブ websockets （利用可能であれば）もしくはフォールバックとして XHR ポーリングや Socket.IO のフォールバック機構のいずれかを使用してリアルタイムコンテンツを提供するようになるでしょう。

websocket の代替手段はオーバーヘッドや初期接続レイテンシを増加させるため Strict モードを有効にすることで、websockets をサポートしていないクライアントを拒否するように設定できます。

``` coffee-script
SS.config.browser_check.strict = true
```
    
Strict モードを有効にすることで Chrome 4以降、Safari 5以降、Firefox 6以降のみが SocketStream アプリを通信できるようになります。それ以外のブラウザがアクセスした場合、 /app/views/incompatible.jade（もしくは.html）の内容が表示されます（ファイルが存在する場合）。このファイル名は `SS.config.browser_check.view_name` の値によって変更できます。

注釈: HTTP APIリクエストの際は SS.config.browser_check.strict の値にかかわらず互換性チェックは行われません。
