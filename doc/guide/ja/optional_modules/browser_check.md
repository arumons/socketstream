<!--
### Browser Check - dealing with incompatible browsers

_Module status: Disabled by default. Enable with `SS.config.browser_check.enabled = true`_
-->

### ブラウザチェック - 非互換のあるブラウザとのやりとり

_Module status: 既定では無効です。 `SS.config.browser_check.enabled = true` で有効にできます。_

<!--
By default SocketStream will attempt to serve real time content to all browsers - either using native websockets (if available) or by falling back to XHR Polling or another Socket.IO fallback transport.
-->

既定の SocketStream では(もし有効なら)ネイティブな websockets を使用したり、XHR ポーリングや他の Socket.IO フォールバック転送を使用したりして、すべてのブラウザにリアルタイムコンテンツを提供しようとします。

<!--
As fallback transports are not ideal (more overhead, initial connection latency) you may prefer to refuse clients which don't support websockets by enabling Strict Mode:

``` coffee-script
SS.config.browser_check.strict = true
```
-->

フォールバック転送は利用的ではないので(オーバーヘッドや初期接続レイテンシがより大きい)  Strict Mode を有効にした websockets をサポートしないクライアントは拒否したいかもしれません。:

``` coffee-script
SS.config.browser_check.strict = true
```

<!--
Once set, only Chrome 4 and above, Safari 5 and above and Firefox 6 and above will be allowed to connect to your app. All others will be shown /app/views/incompatible.jade (or .html) if present. The name of this view can be customized with `SS.config.browser_check.view_name`.
-->

ひとまず、Chrome 4 以上、Safari 5 以上や Firefox 6 以上であれば、あなたのアプリケーションに接続することができるでしょう。 今では /app/views/incompatible.jade (か .html) に他の許可リストを確認できるでしょう。 このビューは `SS.config.browser_check.view_name` の名前でカスタマイズすることができます。

<!--
Note: The serving of HTTP API requests occurs before the browser is checked for compatibility and is hence not affected by these settings.
-->

注: これらの設定が影響を受けないようにブラウザの互換性チェックの前に HTTP API リクエストが提供されます。
