<!--
### Virtual Hosting
-->
### バーチャルホスティング

<!--
[Bouncy](https://github.com/substack/bouncy) is a great new `npm` package that transparently sends HTTP, HTTPS and WebSocket traffic to another TCP port according to the domain name visited; thus allowing you to run multiple SocketStream apps on one server.
-->
[Bouncy](https://github.com/substack/bouncy) はドメイン名に応じて HTTP、HTTPS、WebSocket のトラフィックを別のポートに送ることができるようになる素晴らしい `npm` パッケージです。これによって複数の SocketStream アプリを一つのサーバーで立ち上げることができるようになります。

<!--
#### Walkthrough
-->
#### ウォークスルー

<!--
Let's say you have two SocketStream applications: `fantasticapp.com` running on port 3000, and `awesomeapp.io` running on port 3001. Let's assume both applications are running right now, and that there are no processes bound to port 80 on the server.
-->
ポート番号3000 で稼働している `fantasticapp.com` と 3001番 で稼働している `awesomeapp.io` の２つの SocketStream アプリケーションをあなたは持っています。ポート80番に紐づいているプロセスがない状態で、これら２つのアプリを立ち上げることを想定してみましょう。

<!--
The first step is to install bouncy:
-->
下記がbouncy をインストールするための第一歩です。

    npm install bouncy

<!--
Next, create a simple CoffeeScript file (called `routes.coffee`) that will run continuously:
-->
次に、`routes.coffee` というファイル名の CoffeeScript を作成します。これは継続的に実行されます。

``` coffee-script
bouncy = require 'bouncy'

bouncy (req, bounce) ->
  switch req.headers.host
    when 'fantasticapp.com' then bounce 3000
    when 'awesomeapp.io' then bounce 3001
    else
      console.log "申し訳ありません。 #{req.headers.host} は提供できるサービスのリストにありません"
.listen 80
```

<!--
Run this script with the following command:

    sudo coffee routes.coffee

And there you go! Visit one of the domains you've configured and you'll instantly be directed to the correct SocketStream app.
-->
このスクリプトを下記のコマンドで起動します。

    sudo coffee routes.coffee

起動したらサイトを見てみましょう！設定したドメインを尋ねると即座に SocketStream アプリに繋がると思います。
