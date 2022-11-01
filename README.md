| User            |            |
|-----------------|------------|
| カラム          | データ型   |
| user_id         | string     |
| name            | string     |
| email           | string     |
| password_digest | string     |
|                 |            |
| Task            |            |
| カラム          | データ型   |
| task_id         | string     |
| user_id         | references |
| name            | string     |
| detail          | string     |
| priority        | integer    |
| limit           | date       |
|                 |            |
| Label           |            |
| カラム          | データ型   |
| label_id        | string     |
| user_id         | references |
| task_id         | references |


### herokuへのデプロイ手順
--------
herokuへログイン

```
$heroku login
```
Herokuに新しいアプリケーションを作成
```
$heroku create
```
GemfileにGemを追加
```
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
```
bundle installを実行
```
$bundle install
```
git add. と git commitを実行
```
$git add .
```
```
$git commit -m "herokuデプロイ"
```
step2ブランチの変更内容をHerokuのmasterブランチに反映
```
$git push heroku step2:master
```
herokuテーブル作成
```
$heroku run rails db:migrate
```