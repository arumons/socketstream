<!--
### Client-side Templates
-->

### クライアント側テンプレート

<!--
Client-side templates are a vital part of any SocketStream application. They are used to transform incoming JSON data into chunks of HTML to be rendered in the browser.
-->

クライアント側テンプレートは SocketStream アプリケーションの根幹で、
受け取った JSON データから HTML 断片に変換され
ブラウザ内にレンダリングされます。

<!--
If you've used Ruby on Rails before you'll find the idea very similar to partials; however, whereas Rails uses partials to generate HTML on the server, in SocketStream only raw data should be sent over the websocket. This not only dramatically reduces bandwidth, but also gives you flexibility to transform the data into HTML in a number of ways.
-->

もし以前に Ruby on Rails を使ったことがあるなら、 partials にとてもよく似ているアイデアだとわかるでしょう。しかしながら、 Rails ではサーバー上で生成した HTML の partials を利用しますが、SocketStream では、生データだけが websocket に送られるべきです。これは劇的に帯域幅を縮小するだけでなく、データをたくさんの方法で HTML に変換する柔軟性を与えます。 

<!--
Note: SocketStream bundles jQuery and [jQuery Templates](http://api.jquery.com/category/plugins/templates) with every new project by default; however you are not forced to use either. Just delete the bundled files in /lib/client if you wish to use different libraries such as [Zepto](http://zeptojs.com) or [Mustache](https://github.com/janl/mustache.js).
-->

メモ: SocketStream ではすべての新しいプロジェクトには既定で、jQuery and [jQuery Templates](http://api.jquery.com/category/plugins/templates)がバンドルされます。; しかし、使用を強制しているわけではありません。[Zepto](http://zeptojs.com) や [Mustache](https://github.com/janl/mustache.js) といった別のライブラリを使いたいときは、 /lib/client 配下のファイルを削除するだけです。

<!--
#### Why use client-side templates?
-->
#### なぜクライアント側テンプレートを利用するのか？


<!--
If your app is really simple, you may be happy concatenating strings of HTML together and outputting them on screen using simple jQuery functions:

``` coffee-script
# Client-side code
SS.server.products.latest (products) ->
  products.forEach (product) ->
    $('#products').append("<li>A product called #{product.name} sells for <strong>#{product.price}</strong></li>")
```
-->

もし、あなたのアプリケーションが単純な場合、簡単な jQuery 関数を使って画面に HTML の連結文字列を出力するのが幸せかもしれません。：

``` coffee-script
# Client-side code
SS.server.products.latest (products) ->
  products.forEach (product) ->
    $('#products').append("<li>A product called #{product.name} sells for <strong>#{product.price}</strong></li>")
```

<!--
However, this solution doesn't scale well; plus mixing display logic and HTML together in the same file is messy. Enter client-side templates.
-->

しかし、この解法ではうまくスケールしません；画面表示とロジックを一緒に HTML として同じファイルに混ぜるのは見るに堪えません。クライアント側テンプレートの出番です。

<!--
#### jQuery Templates
-->

#### jQuery テンプレート

<!--
To cleanup the example above let's make a new directory in /app/views called `templates`. Inside /app/views/templates create a file called `products.html` containing the following:

``` html
<li>A product called {{= name}} sells for <strong>{{= price}}</strong></li>
```
-->

さて、例として /app/views に `templates` と名づけた新しいディレクトリを作成しましょう。 Inside /app/views/templates の中に次のような内容で `products.html` と名づけたファイルを作成します。

``` html
<li>A product called {{= name}} sells for <strong>{{= price}}</strong></li>
```

<!--
If you refresh the page and view the HTML source code you'll see a new `<script>` tag included with the other headers:

``` html
<script id="templates-products" type="text/x-jquery-tmpl"><li>A product called {{= name}} sells for <strong>{{= price}}</strong></li></script>
```
-->

ページを更新して HTML のソースコードを見ると、別のヘッダーを含んだ新しい `<script>` タグを確認できるでしょう。

``` html
<script id="templates-products" type="text/x-jquery-tmpl"><li>A product called {{= name}} sells for <strong>{{= price}}</strong></li></script>
```

<!--
Note how the template ID has been automatically concatenated into `templates-products` based upon the name of the directory and file. You may create unlimited sub-directories of /app/views with any name you wish; hence a template with a path of /app/views/screens/admin/login.html would be given an ID of `screens-admin-login`.

Now we can clean up our display logic by passing the array of product data directly into the template we've just created:

``` coffee-script
# Client-side code
SS.server.products.latest (products) ->
  $('#templates-products').tmpl(products).appendTo('#products')
```
-->

どのようにテンプレート ID が自動でディレクトリとファイルの名前に基づいて `templates-products` に連結されるか注目しましょう。 /app/views 配下に望む任意の名前でサブディレクトリを制限なく作成できます。； これにより /app/views/screens/admin/login.html とパスを持つテンプレートは `screens-admin-login` という ID を与えられることになります。

さて、たった今作成したテンプレートに製品データの配列を直接渡すことにより、画面表示とロジックがきれいになりました。：

``` coffee-script
# Client-side code
SS.server.products.latest (products) ->
  $('#templates-products').tmpl(products).appendTo('#products')
```

<!--
If you prefer, you may also use Jade to construct your HTML templates, simply name your template files `.jade`
-->

もし HTML テンプレートに Jade を使うのが好みなら、単にテンプレートのファイル名を `.jade` にするだけです。

<!--
Learn more about jQuery templates at http://api.jquery.com/category/plugins/templates/
-->

jQuery テンプレートについての詳細は http://api.jquery.com/category/plugins/templates/ で確認できます。

<!--
#### Why not do all templating with Jade?
-->

#### Jade だけでテンプレートを構築するとは限らない場合は？

<!--
Because SocketStream is a single-page web framework which only uses Jade to serve the initial page of HTML. This is typically the layout; containing a header, navigation, sidebar, footer etc.
-->

SocketStream は単一ページウェブフレームワークなので、 HTML の最初のページを受け取る Jade を使うだけです。 これは典型的なレイアウトです。；ヘッダー、ナビゲーション、サイドバー、フッター等を含んでいます。

<!--
Once this initial 'payload' has been sent to the browser, no more HTML should ever be generated on the server. However, as you will note above, you may still use Jade to design the structure of your templates if you wish. In fact, we recommend you do.
-->

この最初の「ペイロード」は以前はブラウザから送られていましたが、これ以上 HTML はサーバー側で生成されるべきではありません。しかしながら、上記のことを気をつければ、思うようにテンプレートの構造設計に Jade を使うことができます。実際、そうすることをお勧めします。
