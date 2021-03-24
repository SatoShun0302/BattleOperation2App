# battle_operation2_app
【目次】  
* [ページ一覧と機能概要](#ページ一覧と機能概要)
* [DB構成](#DB構成)
* [ローカルストレージ構成](#ローカルストレージ構成)

## ページ一覧と機能概要
### 【メインページ】
― 現在の階級やニックネーム、好きな機体が記載されたプレイヤーカード（簡易版）を表示  
― アプリからのお知らせや広告、動画広告を表示  

### 【プロフィールページ】
― ニックネーム、階級、好きな機体、好きな作品、好きなキャラクターなどを登録し、スクリーンショットを撮影して  
　ツイッターなどのSNSで紹介するためのプレイヤーカード（詳細版）を編集、確認する

### 【過去の戦績登録画面】
― マップ、コスト別に、自分の戦績を登録することができる  
― 機体の兵科、機体名、味方の編成（兵科と機体名）、出撃時間帯、出撃前の勝ち負け予想、試合結果を登録できる  
− 出撃前情報登録を入力後に"出撃前情報登録ボタン"を押下することで情報を記録し、試合結果入力画面へと進む  
  試合結果入力後に"試合結果登録ボタン"を押下することで戦績を登録する  
  試合結果を登録しなかった場合は出撃前情報も破棄される  

### 【過去の戦績確認画面】
― マップ、コスト別に自分の過去の戦績を登録することができる  
― 兵科ごとの勝率、機体ごとの勝率、編成ごとの勝率、時間帯別勝率（グラフ）、負け予想を覆した割合、勝ち予想が覆った割合を見る事ができる

## DB構成
*強調*されているカラムは必須　その他は任意
### 【機体一覧テーブル】
全ての機体情報を保持する  
同名機体でも、レベルが違う場合は別レコードとしてデータを格納する  
アプリ初回インストール時には、csvファイルからデータを読み込みレコードを作成する  
毎週木曜日に追加された機体のデータをS3へ配置、APIでデータを取得しテーブルを更新する  
|*id*|*機体名*|*機体Lv*|*MSタイプ*|*地上出撃可否*|*宇宙出撃可否*|*出撃可能コスト帯*|
|:---|:---|:---|:---|:---|:---|:---|
|int|String|int|String|bool|bool|int|  

### 【マップ一覧テーブル】  
全てのマップ情報を保持する  
マップが追加された場合はマップデータをS3へ配置、APIでデータを取得しテーブルを更新する  
|*id*|*マップID*|*マップ名*|  
|int|int(地上は1000から1999、宇宙は2000から2999)|String|  

### 【過去戦績テーブル】
自分の過去の戦績を保持する
バックアップは基本不可とし、アプリを消した場合はデータも消える
課金プランとしてデータバックアップを設ける（未定）
|*id*|*マップID*|*コスト*|*出撃時間帯*|*出撃曜日*|*MSタイプ*|機体id|チームの人数|強襲の数|汎用の数|支援の数|試合前勝ち負け予想|*試合結果*|
|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
|int|int|int|int(HHmm)|int(0~7)|String|int|int|int|int|int|int  (0:負け  1:勝ち  2:引き分け)|int  (0:負け  1:勝ち  2:引き分け)|  

## ローカルストレージ構成
■ プロフィール情報  
以下の情報をjson形式のテキストで持つ
- ニックネーム  
- 階級  
- PSNID  
- クラン名  
- 好きな機体  
- 好きなキャラクター  
- 好きなシーン
- 一言コメント

■ 通知フラグ  
アプリからの通知を受け取るかどうかのフラグ　種別は以下  
- 木曜日の機体更新をアナウンスするローカル通知  
- 製作者からのお知らせを行うプッシュ通知  
- 動画投稿者からの更新を知らせるプッシュ通知（未定）  

■ 投票回数  
負けに繋がりやすい機体、勝ちに繋がりやすい機体の1日あたりの投票回数を超えているか否かのフラグ  
各項目1日5回まで投票可能とする(2021/03/21現在)  
- 負けに繋がりやすい機体投票回数  
- 勝ちに繋がりやすい機体投票回数  

■ 投票可否フラグ  
上記の投票回数を参照し、残り回数がある場合はtrue、ない場合はfalseとする  
毎日00:00のタイミングでリセットする  
- 負け機体投票可否フラグ  
- 勝ち機体投票可否フラグ  

■ 最終投票日時  
最後に投票した日時を記録しておき、記録した日付より1日以上進んでいるか否かを判定する  


