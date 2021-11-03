/**
 * enumは全てこのファイルに定義する
 */
import 'package:battle_operation2_app/importer/dart_importer.dart';

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
extension MobileSuitTypeExtension on MobileSuitType {
  /// MSタイプ　英語
  String get nameEn {
    switch (this) {
      case MobileSuitType.Raid:
        return "Raid";
      case MobileSuitType.General:
        return "General";
      case MobileSuitType.Support:
        return "Support";
    }
  }

  /// MSタイプ 日本語（省略形）
  String get nameJaShortened {
    switch (this) {
      case MobileSuitType.Raid:
        return "強";
      case MobileSuitType.General:
        return "汎";
      case MobileSuitType.Support:
        return "支";
    }
  }

  Color get msTypeColor {
    switch (this) {
      case MobileSuitType.Raid:
        return Color.fromRGBO(203,0,0,1);
      case MobileSuitType.General:
        return Color.fromRGBO(0,101,203,1);
      case MobileSuitType.Support:
        return Color.fromRGBO(203,203,0,1);
    }
  }
}

/// 戦場のタイプ
enum FieldType {
  Ground,
  Space
}

/// SharedPreferencesのkey一覧
enum SharedPrefKey {
  /// bool アプリインストール後初回起動か否か
  DoneFirstProcess,
  /// bool データベースを作成済みかどうか
  MadeDatabase,
  /// bool 機体一覧初期データを挿入済みか否か
  InsertedInitMsRecord,
  /// bool 強襲機初期データ挿入に成功したか否か
  SuccessInsertRaidMs,
  /// bool 汎用機初期データ挿入に成功したか否か
  SuccessInsertGeneralMs,
  /// bool 支援機初期データ挿入に成功したか否か
  SuccessInsertSupportMs,
  /// bool マップ一覧初期データを挿入済みか否か
  InsertedInitMapRecord,
  /// bool コスト一覧初期データを挿入済みか否か
  SuccessInsertCost,
  /// プロフィール情報
  Profile,
  /// bool ローカル通知フラグ
  LocalNotificationFlag,
  /// bool プッシュ通知フラグ
  PushNotificationFlag,
  /// 負け機体投票回数
  LoseMsVoteNumber,
  /// 勝ち機体投票回数
  WinMsVoteNumber,
  /// 負け機体投票可否フラグ
  CanVoteLoseMs,
  /// 勝ち機体投票可否フラグ
  CanVoteWinMs,
  /// 最後に投票を行った日時
  LastVoteDatetime,
  /// 投票権付与最終日
  VoteRightGrantDay
}