
/// 地上及び宇宙戦績の各マップ、コストごとのフィールドを保持しておく為のモデルクラス
class MyBattleRecordSingle {
  /// レコード数(総試合数)
  int recordNum = 0;
  /// 勝利数
  int winNum = 0;
  /// 敗北数
  int loseNum = 0;
  /// 汎用使用数
  int useGeneralNum = 0;
  /// 支援使用数
  int useSupportNum = 0;
  /// 強襲使用数
  int useRaidNum = 0;
  /// 時間帯別勝率
  Map<String, int> timeWinRate = new Map();
  /// 曜日別勝率
  Map<String, int> dayOfTheWeekWinRate = new Map();
}