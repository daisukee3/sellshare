# SellShare
営業パーソンが日々の悩みや思いを誰でも簡単に投稿できるSNS投稿サービス。  
下記ページにて公開しております。  

URL(AWS)：https://www.sellshare.ml/users/sign_in?locale=ja

URL(Heroku):https://sellshare.herokuapp.com/users/sign_in?locale=ja

# アプリケーションの概要  
日々会社のため営業活動に勤しんでいる営業職が悩みや学びを投稿し、  
他ユーザーがコメントすることで意見を交換したり、  
いいねボタンで共感しながら交流することでお互いに成長していく営業パーソン向けSNS投稿サービス。  
他者閲覧不可能のパーソナル空間で日々の思いをさらけ出すグチ投稿機能実装  
最新のビジネスニュースを閲覧できる機能なども実装  

下記、Qiita記事にて作成した背景や想いなど、より詳細な情報を公開しております。  
https://qiita.com/daisukee3/private/370320c035434b5610b2

# 技術的ポイント
・RSpecでModel, Request, Systemテスト記述（計133examples）  
・Ajaxを用いた非同期処理（コメント投稿、グチ投稿、フォロー/アンフォロー、お気に入り登録/未登録などの切り替え表示）  
・NewsAPIを使用したビジネスニュース閲覧機能  
・Rubocopを使用したコード規約に沿った開発  
・adminユーザーを設定し、管理者が不適切な投稿やユーザーの削除をできるよう設定  
・レスポンシブ表示対応しており、Webブラウザ、スマホ共に表示可能。  

# アプリケーションの機能  
・投稿機能:  
 営業の悩みや相談事、ふとした呟きなどを投稿可能(ActiveRecordを使用し、画像も添付可能)  
・グチ投稿機能:  
 日々の溜まった愚痴を思う存分投稿可能。  
 他ユーザー閲覧不可能のため好きなだけ愚痴をブチまけることができ、  
 日付変更のタイミングにて投稿は全て非表示になるため、昨日の感情を翌日に残しません。Ajax）  
・ビジネスニュース閲覧機能(NewsAPI使用)  
・フォロー(Ajax)  
・お気に入り登録(Ajax)  
・コメント(Ajax)  
・プロフィール  
・通知機能（お気に入り登録 or コメントがあった場合 or フォローされた場合）  
・投稿検索機能（Ransackを使用）  
・投稿は①全ての投稿、②フォロワーの投稿、③人気な投稿のランキング、④お気に入りの投稿を一覧で表示可能  
・ログイン機能(devise)  
・ページネーション機能(kaminari)  
・モデルに対するバリデーション  
・SNSシェア機能: Twitterでアプリを共有することが可能  
・ホーム画面では①全投稿②フォロー中のユーザーの投稿③お気に入り登録の多い投稿④お気に入りの投稿の4種をタブで切り替え可能  

# その他  
現在も開発を継続しており、順次実装予定です。  
実装予定の機能はIssuesへ追加していきます。  

# 環境  
■ フレームワーク  
　Ruby on Rails  
■ データベース  
　PostgreSQL  
■ インフラ  
　AWS( VPC | ELB | EC2 | S3 | Route53 | ACM | RDS | EIP | IAM ）  
 
# 作者   
Twitter:  
<https://twitter.com/Daisuke4321234>  
mail to:  
d15.daisuke.nabatame@gmail.com  
