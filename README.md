# battle_operation2_app

A new Flutter application.

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

### 【過去の戦績確認画面】
― マップ、コスト別に自分の過去の戦績を登録することができる  
― 兵科ごとの勝率、機体ごとの勝率、編成ごとの勝率、時間帯別勝率（グラフ）、負け予想を覆した割合、勝ち予想が覆った割合を見る事ができる

## DB構成
### 【機体一覧テーブル】
|id|機体名|兵科|地上出撃可否|宇宙出撃可否|出撃可能コスト帯|
|:---|:---|:---|:---|:---|:---|
|int|String|String|bool|bool|String(Listをjsonへ変換)|
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
