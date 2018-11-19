# Dojo-Forum
## 目錄
* [Getting Started](#getting-started)
* [User Story](#user-story)
* [API介面](#api介面)
* [Built With](#built-with)
* [Deploy](deploy)

## Getting Started
#### Install project
```
$ bundle install
$ rails db:migrate
```
#### Setup data for development
```
$ rails db:seed
$ rails dev:fake_all
```
#### Setup environment
本專案將圖片存在雲端服務Cloudinary，須將相關設定存入`config/cloudinary.yml`，
大寫字母為需要修改的內容
```
development:
  cloud_name: "CLOUD_NAME"
  api_key: "API_KEY"
  api_secret: "API_SECRET"
  secure: true
  cdn_subdomain: true

production:
  cloud_name: "CLOUD_NAME"
  api_key: "API_KEY"
  api_secret: "API_SECRET"
  secure: true
  cdn_subdomain: true
```


## User Story
#### 使用者認證
* 使用者可以註冊、登入 (使用 Devise gem)
  * 除了文章總表，都需要登入

#### 後台管理介面
* 進入後台必須有管理員 (admin) 權限（後台路由請設為 /admin）
* 請撰寫 seed.rb，新增一組預設管理員，限定帳號：admin@example.com；密碼：12345678
* 後台可以 CRUD 文章的分類 (但不能刪除已經有被使用的分類)
* 後台可以瀏覽所有使用者清單，清單上可一目了然使用者的姓名、基本資料、是否有管理員 (admin) 權限
* 後台可以把其他使用者加為管理員 (admin)
* 管理員 (admin) 在前台瀏覽文章時，可以刪除任何人的文章

#### 文章 CRUD
* 使用者可以瀏覽文章總表（每頁顯示 20 筆），並且在總表上一目瞭然：
  * 每篇主題有多少回覆數 (replies_count)
  * 每篇文章有多少瀏覽數 (viewed_count)
* 使用者可以瀏覽文章詳細內容
  * 可以在同一頁直接進行回覆 (Reply)
  * 在同一頁看見回覆內容，每頁最多顯示 20 筆回覆
  * 若使用者是該文章/回覆的作者，在本頁面可以同步進行編輯和刪除
* 使用者瀏覽文章總表時，預設是按 id 排序，但也可以自訂：
  * 可選擇用「最後回覆時間」排序文章
  * 可選擇用「最多人進行回覆」排序文章
  * 可選擇用最多人瀏覽數排序文章
* 使用者可以張貼文章
  * 張貼文章時，可以附檔上傳一張相片
  * 使用者張貼文章時，可以選擇 Category (多選)，例如 [ ] 商業類 [ ] 技術類 [ ] 心理類
* 使用者可以瀏覽特定分類的文章
* 使用者瀏覽特定分類文章時，也可以進行分頁和進行排序

#### Profile
* 在任何一個地方點擊使用者暱稱可以進行 Profile 頁，看到個人簡介，包括：
  * 該使用者張貼過的文章
  * 該使用者回覆過的文章
* 使用者可以收藏/取消收藏文章（按鈕以 AJAX 實作），且可以在 Profile 頁裡瀏覽自己收藏的文章列表

#### 全站最新快訊
* 新增一個全站最新快訊的頁面，顯示以下資訊：
  * 全站已註冊的使用者人數
  * 全站總共有多少主題和回覆
  * 最熱門的文章（最多人回覆）
  * 聲量最大的使用者（最多回覆數）

#### 文章狀態
* 新增文章時可以選擇草稿 (Draft) 狀態
  * 草稿狀態只有自己看得到，稍候可以編輯將狀態改成「發布」。
  * 草稿狀態的文章會統一歸進 Profile 頁面裡

#### 好友
* 使用者可以對其他使用者發出好友請求
  * 不能對自己發出好友請求、已經成為好友或已送出也不能再送
  * 可以查看收到的好友請求，回覆答應或忽略（按鈕以 AJAX 實作）
  * 在 Profile 頁裡可以瀏覽我的好友清單

#### 文章權限
* 文章可以設定權限（使用者在瀏覽文章清單時，只會看見自己有權限的文章目錄）：
  * 開放給所有人都可以瀏覽和留言
  * 限定好友才能瀏覽和留言
  * 只有自己可以瀏覽和留言

## API介面
* POST /api/v1/login (登入,登入參數請設定為`emai`及`password`) 
* POST /api/v1/logout (登出) 
* GET /api/v1/posts (瀏覽全部文章內容/不需登入) 
* GET /api/v1/posts/:id (瀏覽單篇文章內容/需登入) 
* POST /api/v1/posts (新增文章/需登入) 
* PATCH /api/v1/posts/:id (編輯文章/需登入) 
* DELETE /api/v1/posts/:id (刪除文章/需登入) 
* GET /api/v1/posts (瀏覽全部文章內容/不需登入) 

## Built With
* ruby 2.5.1
* rails 5.2.1
* Authentication: [Devise](https://github.com/plataformatec/devise)
* Layout: [Bootstrap4](https://github.com/twbs/bootstrap-rubygem), [bootstrap_form](https://github.com/bootstrap-ruby/bootstrap_form)
* Image Uploader: [CarrierWave](https://github.com/carrierwaveuploader/carrierwave), [Cloudinary](https://cloudinary.com/)
* Fake Data: [ffaker](https://github.com/ffaker/ffaker)
* Pagination: [Pagy](https://github.com/ddnexus/pagy), [Kaminari](https://github.com/kaminari/kaminari)
* Table Sort: [WiceGrid](https://github.com/patricklindsay/wice_grid)

## Deploy
Deploy on [Heroku](https://www.heroku.com/)

https://wendy-dojo.herokuapp.com/
