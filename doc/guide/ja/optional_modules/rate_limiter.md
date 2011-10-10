<!--
### Rate Limiter

_Module status: Disabled by default. Enable with `SS.config.rate_limiter.enabled = true`_
-->

### レート制限

_Module status: 既定では無効です。`SS.config.rate_limiter.enabled = true` で有効になります。 _

<!--
SocketStream can provide basic protection against DDOS attacks by identifying clients attempting to make over 15 requests per second over the websocket connection (configurable with SS.config.rate_limiter.websockets.rps).
-->

SocketStream では websocket 接続 ( SS.config.rate_limiter.websockets.rps で設定可能) で毎秒15以上のリクエストを試みるクライアントを識別することで DDOS 攻撃からの基本的な保護を提供できます。

<!--
When this occurs you'll be notified of the offending client in the console and the client will be disconnected.
-->

これが発生したときには、あなたはコンソール上に不快なクライアントに関する通知を受けるとともにそのクライアントは切断されることでしょう。

<!--
For now this feature is very basic but we intend to develop it further in the future.
-->

今のところ、このフィーチャは非常に基礎的ですが、今後さらに開発するつもりです。
