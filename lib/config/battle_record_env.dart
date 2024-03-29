
/// 戦績データ登録、戦績データ参照時に使用する定数
class BattleRecordEnv {
  /// 地上マップの最小id 1000
  static const int groundMapIdMin = 1000;
  /// 地上マップの最大id 1999
  static const int groundMapIdMax = 1999;
  /// 宇宙マップの最小id 2000
  static const int spaceMapIdMin = 2000;
  /// 宇宙マップの最大id 2999
  static const int spaceMapIdMax = 2999;
  /// 対戦人数候補リスト
  static const numberOfPlayer = ["5 vs 5", "6 vs 6"];
  /// チーム選択 A
  static const String teamSideA = "A";
  /// チーム選択 B
  static const String teamSideB = "B";
  /// 勝利(int)
  static const win = 1;
  /// 敗北(int)
  static const lose = 0;
}