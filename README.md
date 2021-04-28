# README

## 名称
Giji-memo

## 概要
議事録の作成を省力化、他ユーザーと議事録を共有出来る業務支援アプリケーション

## 本番環境
https://gijimemo-app.herokuapp.com/

テストアカウント guestuser1
- Email: guestuser-1@test.com
- Password: 1234abcd

テストアカウント guestuser2
- Email: guestuser-2@test.com
- Password: 1234abcd

## 制作背景
様々なビジネスにおいて、会議や打ち合わせの議事録作成は付き物です。重要な意思決定を記録に残し、共有するための大切な書類ですが、作成に思わぬ時間がかかり通常業務の時間を圧迫している方もいるのではないでしょうか。また、作成した議事録を紙で回覧していると期間が経ってしまい、最後に読む上司の方は話の細かな内容について記憶が薄らいでしまっている、ということも有るかもしれません。

このアプリケーションは、そのような課題を解決するために**議事録作成の省力化・スピーディな共有**を目的として制作しています。

録音した音声データがあれば、自動でテキストに変換します。MP3, FLAC, WAVのファイル形式に対応し、1ファイルあたり最大480分間の音声データを使用できます。ICレコーダーやスマートフォンからの録音、Web会議サービスの録音機能などを使ってお試しください。
また、作成した議事録は任意のユーザーと共有し、コメントをつけて議事録の内容についてレビューをもらうことができます。

## 開発環境
### サーバーサイド
Ruby 2.6.5, Ruby on Rails 6

### フロントエンド
HTML, CSS, Javascript, Ajax

### インフラ
GCS

## 今後の課題、実装予定
* 議事録の一覧表示画面が、作成日順に全表示される仕様となっています。検索機能、ソート機能を追加予定です。

## DB設計
### usersテーブル
|Column            |Type  |Options                  |
|------------------|------|-------------------------|
|nickname          |string|null: false              |
|encrypted_password|string|null: false              |
|email             |string|null: false, unique: true|

#### Association
- has_many :meetings
- has_many :access_permits
- has_many :transcripts
- has_many :reactions
- has_one  :profile

### meetingsテーブル
|Column      |Type      |Options                       |
|------------|----------|------------------------------|
|name        |string    |null: false                   |
|meeting_date|date      |                              |
|meeting_time|time      |                              |
|place       |string    |                              |
|attendance  |text      |                              |
|speech      |text      |                              |
|user        |references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- has_many :access_permits
- has_many :reactions

### access_permitsテーブル
|Column |Type      |Options                       |
|-------|----------|------------------------------|
|user   |references|null: false, foreign_key: true|
|meeting|references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :meeting

### transcriptsテーブル
|Column    |Type      |Options                       |
|----------|----------|------------------------------|
|name      |string    |null: false                   |
|transcript|text      |null: false                   |
|status    |integer   |null: false                   |
|user      |references|null: false, foreign_key: true|

#### Association
- belongs_to :user

### reactionsテーブル
|Column |Type      |Options                       |
|-------|----------|------------------------------|
|comment|text      |null: false                   |
|user   |references|null: false, foreign_key: true|
|meeting|references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :meeting

### profilesテーブル
|Column           |Type  |Options                  |
|-----------------|------|-------------------------|
|family_name      |string|                         |
|first_name       |string|                         |
|belonging        |string|                         |
|self_introduction|text  |                         |

#### Association
- belongs_to :user