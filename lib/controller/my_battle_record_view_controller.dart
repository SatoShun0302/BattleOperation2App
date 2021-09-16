import 'package:battle_operation2_app/controller/my_battle_record_add_controller.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// 過去
class MyBattleRecordViewController extends GetxController {
  final MyBattleRecordAddController c = Get.find(tag: "myBattleRecordAdd");

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

  /// コストリスト
  List<int> costList = [];

  /// MSタイプリスト
  Map<int, String> msTypeList = new Map();

  /// 選択されたコスト帯
  RxInt choosedCost = 0.obs;

  /// 選択されたマップのid　地上は1001~1999　宇宙は2001~2999
  RxInt choosedStageId = 0.obs;

  /// レコード数(総試合数)
  int totalRecordNum = 0;

  /// 勝利数
  int totalWinNum = 0;

  /// 敗北数
  int totalLoseNum = 0;

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