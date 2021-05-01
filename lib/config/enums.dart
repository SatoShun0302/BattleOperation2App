/**
 * enumは全てこのファイルに定義する
 */
/// null safety版ではクラス及びメソッドが定義されていないファイルのexportができないため
/// dummyクラスとdummyメソッドを記述する
class dummyEnum {
  void dummy() {}
}
/// MSのタイプ
enum MobileSuitType {
  General,
  Support,
  Raid
}

/// 戦場のタイプ
enum FieldType {
  Ground,
  Space
}

/// SharedPreferencesのkey一覧
enum SharedPrefKey {
  DoneFirstProcess, // アプリインストール後初回起動か否か
  MadeDatabase, // データベースを作成済みかどうか
  InsertedInitMsRecord, // 機体一覧初期データを挿入済みか否か
  InsertedInitMapRecord, // マップ一覧初期データを挿入済みか否か
  Profile, // プロフィール情報
  LocalNotificationFlag, // ローカル通知フラグ
  PushNotificationFlag, // プッシュ通知フラグ
  LoseMsVoteNumber, // 負け機体投票回数
  WinMsVoteNumber, // 勝ち機体投票回数
  CanVoteLoseMs, // 負け機体投票可否フラグ
  CanVoteWinMs, // 勝ち機体投票可否フラグ
  LastVoteDatetime, //
  VoteRightGrantDay // 投票権付与最終日
}