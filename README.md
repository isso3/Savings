# SAVING!
このアプリは貯金アプリです。記録していきお金を節約していきましょう。

# Description
このアプリでは、30日間のユーザーごとの貯金額の変化をグラフ形式で確認できます。日本の午前0時を過ぎた日の収支額を記録し、間違えても修正できます。

# Production environment
### ホームページ
- http://54.249.145.150/
### テストアカウント
- メールアドレス：test@saving.com
- パスワード：111111

# Production background
自分自身や友人と話している中で、節約に苦手意識があるということに気づき当アプリを制作しました。またDB関連の流れや、bootstrapの導入やchartkickの導入などに関する知識を深めるという裏目標も兼ねて制作をいたしました。

# DEMO
- https://github.com/isso3/Savings/issues/30#issue-621930273


# Points devised
時間系のメソッドを使用し収支額を記入した次の日に入力ボタンから更新ボタンへ変更するようにしました。
更新をした場合でもその元からある貯金額から計算するように設計しました。
bootstrapである程度携帯で見た場合でも対応出来るようにしました。
chartkickを使って直感的に自分の貯金額の推移がわかるようにしました。

# Development environment
- Ruby 2.5.1
- Ruby on Rails 5.0.7.2
- Bootstrap 4.4.1
- Chartkick 3.3.1
- Devise 4.7.1

# 課題や今後実装したい機能
個人かつ機能重視で作ったため、コードの可読性が悪く他人が読んだ場合読みづらい箇所があると思うので可読性のあるコードを書いていきたいのと、グラフの日付の表示が初期状態のままで変更しようにも変更出来なかったため初期設計が甘くもう少し見積っていたらもっと見やすいグラフになっていたと思うのでそこを直していきたい。

# DB

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|username|string|null: false|
|email|string|null: false|default: ""|
|encrypted_password|string|null: false|default: ""|
|reset_password_token|string|
|reset_password_sent_at|datetime|
|remember_created_at|datetime|

### Association
- has_many :savings, foreign_key: :user_id, dependent: :destroy

## savingsテーブル
|Column|Type|Options|
|------|----|-------|
|total_savings|bigint|
|month_income|bigint|
|daily_consumption|bigint|
|daily_income|bigint|
|user_id|integer|foreign_key: true|

### Association
- belongs_to :user