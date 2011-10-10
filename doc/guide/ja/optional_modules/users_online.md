<!--
### Tracking Users Online
-->

### ユーザーのオンライン状態を追跡する

<!--
** Important: This feature requires Redis support to be enabled. Ensure `SS.config.redis.enabled = true` and that Redis is installed and running**

_Module status: Enabled by default. Disable with `SS.config.users_online.enable = false`_
-->

** 重要: このフィーチャーは Redis サポートを有効にする必要があります。 Ensure `SS.config.redis.enabled = true` を確認し、 Redis をインストールして実行してください。**

_Module status: 既定で有効です。 `SS.config.users_online.enable = false`  で無効になります。_ 

<!--
Once users are able to authenticate and log in, you'll probably want to keep track of who's online - especially if you're creating a real-time chat or social app. We've built this feature into SocketStream as an optional module.
-->

一旦ユーザーが認証しログインできたなら、おそらく誰もがオンラインかどうか追跡したいと思うでしょう。 - 特にリアルタイムチャットやソーシャルアプリを作っている場合は。私たちはオプションモジュールとして SocketStream にこのフィーチャを組み込みました。

<!--
When a user successfully authenticates (see section above) we store their User ID within Redis. You may obtain an array of User IDs online right now by calling this method in your server-side code:

``` coffee-script
SS.users.online.now (data) -> console.log(data)
```
-->

ユーザーが認証に成功した場合（上のセクションを参照）、SocketStream では Redis 内にユーザーIDを格納します。 あなたはサーバー側のコードでこのメソッドを呼ぶだけでオンラインユーザーIDを含んだ配列を手に入れられます。：

``` coffee-script
SS.users.online.now (data) -> console.log(data)
```

<!--
If a user logs out, they will immediately be removed from this list. But what happens if a user simply closes down their browser or they lose their connection?
-->

もしユーザーがログアウトした場合は、すぐにこのリストから除かれるでしょう。でも、ユーザーが単にブラウザを閉じたり接続が切れただけのときはどうでしょう？

<!--
When this feature is enabled the SocketStream client sends an ultra-lightweight 'heartbeat' signal to the server every 30 seconds confirming the user is still online. On the server side, a process runs every minute to ensure users who have failed to check in within the last minute are 'purged' from the list of users online.
-->

このフィーチャが有効な場合、SocketStream クライアントはユーザーがまだオンラインかどうか30秒毎にサーバーに超軽量な「ハートビート」で確認します。サーバー側では、ユーザーのオンラインリストから直近1分にチェックインしていないユーザーを「取り除く」ため毎分プロセスを実行します。

<!--
#### Config Options
-->

#### オプション構成

<!--
All timings can be configured using `SS.config.client.heartbeat_interval` and the various params within `SS.config.users_online`.
-->

すべてのタイミングは `SS.config.client.heartbeat_interval` と `SS.config.users_online` 内のいろいろなパラメーターを使って構成することができます。
