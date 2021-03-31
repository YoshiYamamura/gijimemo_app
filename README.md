# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# テーブル設計

## usersテーブル
|Column            |Type  |Options                  |
|------------------|------|-------------------------|
|nickname          |string|null: false              |
|encrypted_password|string|null: false              |
|email             |string|null: false, unique: true|

### Association
- has_many :meetings
- has_many :access_permits
- has_many :transcripts
- has_many :reactions
- has_one  :profile

## meetingsテーブル
|Column      |Type      |Options                       |
|------------|----------|------------------------------|
|name        |string    |null: false                   |
|meeting_date|date      |                              |
|meeting_time|time      |                              |
|place       |string    |                              |
|attendance  |text      |                              |
|speech      |text      |                              |
|user        |references|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_many :access_permits
- has_many :reactions

## access_permitsテーブル
|Column |Type      |Options                       |
|-------|----------|------------------------------|
|user   |references|null: false, foreign_key: true|
|meeting|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :meeting

## transcriptsテーブル
|Column    |Type      |Options                       |
|----------|----------|------------------------------|
|transcript|text      |null: false                   |
|status    |integer   |null: false                   |
|user      |references|null: false, foreign_key: true|

### Association
- belongs_to :user

## reactionsテーブル
|Column |Type      |Options                       |
|-------|----------|------------------------------|
|comment|text      |null: false                   |
|user   |references|null: false, foreign_key: true|
|meeting|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :meeting

## profilesテーブル
|Column           |Type  |Options                  |
|-----------------|------|-------------------------|
|family_name      |string|                         |
|first_name       |string|                         |
|belonging        |string|                         |
|self_introduction|text  |                         |

### Association
- belongs_to :user