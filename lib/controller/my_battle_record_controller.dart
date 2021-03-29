import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// 戦績確認画面用のコントローラー
/// 地上と宇宙の戦績を確認する際に使用する
///
/// 一度検索された条件のデータはモデルクラスのインスタンスに保持し、2回目以降はDBアクセスをしない
///
/// 戦績が新たに登録されたマップとコストについてはインスタンスを破棄し、再度検索を行う
class MyBattleRecordController {

  /// 一度検索されたマップとコストのデータを保持したインスタンスを格納する
  ///
  /// keyは"map0000-cost000"の形式を取る ex."map1001-cost550"
  /// 地上全マップは2000　宇宙全マップは3000
  RxMap<String, MyBattleRecordSingle> battleRecordCache =
      new Map<String, MyBattleRecordSingle>().obs;

  /// 地上マップのドロップダウンリスト
  Map<int, String> groundStageList = new Map();

  /// 宇宙マップのドロップダウンリスト
  Map<int, String> spaceStageList = new Map();

  /// 選択されたマップのid　地上は1001~1999　宇宙は2001~2999
  RxInt choosedStageId = 0.obs;

  /// コストリスト
  List<int> costList = [];

  /// 選択されたコスト帯
  RxInt choosedCost = 0.obs;

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

  /// 地上戦績画面が表示される際の初期処理
  MyBattleRecordSingle? initGroundState() {
    // 選択済みマップとコストを初期化
    choosedStageId.value = 0;
    choosedCost.value = 0;
    // マップリストとコストリストに値が存在しない場合はDBから取得する
    if (groundStageList.isEmpty) {
      //todo DB接続処理
    }
    if (costList.isEmpty) {
      //todo DB接続処理
    }
    // 全マップ全コストの戦績が存在しない場合はDBから取得する
    if (battleRecordCache["map2000-cost0"] != null) {
      //todo DB接続処理
    }

    return battleRecordCache.value["map2000-cost0"];
  }

  /// 宇宙戦績画面が表示される際の初期処理
  MyBattleRecordSingle? initSpaceState() {
    // 選択済みマップとコストを初期化
    choosedStageId.value = 0;
    choosedCost.value = 0;
    // マップリストとコストリストに値が存在しない場合はDBから取得する
    if (spaceStageList.isEmpty) {
      //todo DB接続処理
    }
    if (costList.isEmpty) {
      //todo DB接続処理
    }
    // 全マップ全コストの戦績が存在しない場合はDBから取得する
    if (battleRecordCache["map3000-cost0"] != null) {
      //todo DB接続処理
    }

    return battleRecordCache.value["map3000-cost0"];
  }
}
