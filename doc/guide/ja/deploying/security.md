### セキュリティ

正直なところ、SocketStream がどれくらいセキュアなのか私たちは把握していません。Node.js から SocketStreamクライアントにいたるワンセットはすべて目新しいものばかりなので、リリース可能なちゃんとしたソフトウェアを開発できるように改善している段階です。このような状態なので、SocketStream はファイアウォールで保護して運用することをオススメします。

もしあなたが好奇心に満ちあふれているなら、SocketStream 製の Webサイトをぜひ公開してください。私たちも www.socketstream.org に公開する予定です。ただし、重要なデータはサーバに置かないようにし、なにかあった場合はすぐ復元できるようにしておきましょう。

ソースコードを読んでいて脆弱性を見つけたり、セキュリティホールになりかねないものに出くわしたら、ぜひ私たちにお知らせください。あなたの協力によって、SocketStream 製の Webサイトが安全に公開できる日が近づくでしょう。


#### XSS 攻撃

クイックリマインダ: 他のWebフレームワークと同じように、SocketStream は XSS攻撃を受ける可能性があります。悪意を持ってつくられた UGC（User Generated Content）は、ユーザからの入力時（サーバーサイド）とスクリーンへの出力時（クライアントサイド）でフィルタリングすることをオススメします。将来は 'ヘルパー' にフィルタリング機能を実装する予定です。

whileループで 'SS.server' のメソッドをひたすら呼びつづけるコードを、ユーザが投稿するリンクの最後に埋め込むのはとても簡単です。SocketStream は基本的なレート制限機構を対DDOS用に用意しています。詳細は /doc/guide/ja/optional_modules/rate_limiter.md を見てください。