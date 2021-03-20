/**
 * enumは全てこのファイルに定義する
 */

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
  Profile,
  LocalNotificationFlag,
  PushNotificationFlag,
  LoseMsVoteNumber,
  WinMsVoteNumber,
  CanVoteLoseMs,
  CanVoteWinMs,
  LastVoteDatetime
}