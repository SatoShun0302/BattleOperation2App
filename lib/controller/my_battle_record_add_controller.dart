import 'package:battle_operation2_app/config/battle_record_env.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/model/cost.dart';
import 'package:battle_operation2_app/repository/cost_list_repository.dart';
import 'package:battle_operation2_app/repository/map_list_repository.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;
import 'package:battle_operation2_app/repository/ms_list_repository.dart';

/// 戦績登録画面用のコントローラー.
///
/// 一度検索された条件のMS一覧データはマップに保持し、2回目以降はDBアクセスをしない.
/// お気に入り機体の更新があった際は、お気に入り機体一覧マップを初期化する.
/// MS一覧テーブルの更新があった際は、MS一覧マップを初期化する.
class MyBattleRecordAddController extends GetxController {
  /// 一度検索されたマップとコストに対応したMS一覧データを格納する.
  ///
  /// keyは"canGround(canSpace)-cost000"の形式を取る ex."canGround-cost700".
  Map<String, List<MobileSuit>> battleRecordCache = new Map<String, List<MobileSuit>>();

  /// マップのドロップダウンリスト
  List<DropdownMenuItem<int>> mapDropdownList = [];

  /// 選択されたマップのid　地上は1001~1999　宇宙は2001~2999
  RxInt choosedMapId = 0.obs;

  /// コストのドロップダウンリスト
  List<DropdownMenuItem<int>> costDropdownList = [];

  /// 選択されたコスト帯
  RxInt choosedCost = 0.obs;

  /// 対戦人数のドロップダウンリスト
  List<DropdownMenuItem<int>> numberOfPlayerList = [];

  /// 選択された対戦人数
  RxInt choosedNumberOfPlayer = 0.obs;

  /// MSタイプリスト
  Map<int, String> msTypeList = new Map();

  /// MSリスト
  List<MobileSuit> msList = [];

  /// MSドロップダウンリスト
  List<DropdownMenuItem<Map<int, String>>> msDropdownList = [];

  /// 選択されたMSのid (自機は1,僚機は2~6)
  RxInt choosedMsId1 = 0.obs;
  RxInt choosedMsId2 = 0.obs;
  RxInt choosedMsId3 = 0.obs;
  RxInt choosedMsId4 = 0.obs;
  RxInt choosedMsId5 = 0.obs;
  RxInt choosedMsId6 = 0.obs;
  RxMap choosedMsMap2 = RxMap();
  RxMap choosedMsMap3 = RxMap();


  /// 選択されたチームサイド
  RxString choosedSide = BattleRecordEnv.teamSideA.obs;

  /// 勝敗予想
  RxInt choosedPrediction = 1.obs;


  final String hint = "自機を選択してください";
  final String alliesHint = "僚機を選択してください";
  final String searchHint = "機体名で検索ができます";
  final String favoriteHint = "お気に入り機体から選択します";
  final String copyHint = "選択した機体を下へコピーします";

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


  /// 出撃準備画面１で使用する、マップ一覧を取得する.
  Future<void> getMapList() async {
    MapListRepository mlr = new MapListRepository();
    List<MapList> mapLists = await mlr.getRecord();
    if (mapDropdownList.isEmpty) {
      mapLists.asMap().forEach((index, mapList) {
        if (index == 0) {
          choosedMapId.value = mapList.mapId!;
        }
        mapDropdownList.add(DropdownMenuItem(
          child: myText.Text(
            mapList.mapName ??= "",
            style: TextStyle(fontSize: 15.0),
          ),
          value: mapList.mapId,
        ));
      });
    }
  }

  /// 出撃準備画面１で使用する、コスト一覧を取得する.
  ///
  /// 出撃準備画面１の出撃ボタン押下時に処理を行う.
  Future<void> getCostList() async {
    CostListRepository clr = new CostListRepository();
    List<Cost> costList = await clr.getRecord();
    if (costDropdownList.isEmpty) {
      costList.asMap().forEach((index, cost) {
        if (index == 0) {
          choosedCost.value = cost.cost!;
        }
        costDropdownList.add(DropdownMenuItem(
          child: myText.Text(
              cost.cost.toString(),
              style: TextStyle(fontSize: 15.0),
            ),
          value: cost.cost,
        ));
      });
    }
  }

  /// 出撃準備画面１で使用する対戦人数組み合わせ一覧を取得する.
  Future<void> getNumberOfPlayerList() async{
    if (numberOfPlayerList.isEmpty) {
      BattleRecordEnv.numberOfPlayer.asMap().forEach((index, value) {
        if (index == 0) {
          // 1チームの人数と合わせるためにindexに1をプラスする
          choosedNumberOfPlayer.value = index + 1;
        }
        numberOfPlayerList.add(DropdownMenuItem(
          child: myText.Text(
            value,
            style: TextStyle(fontSize: 15.0),
          ),
          value: index + 1,
        ));
      });
    }
  }

  /// 出撃準備画面２で使用する、MS一覧を取得する.
  ///
  /// 取得済みMSリストマップにデータが存在する場合はDBからの検索を行わない.
  /// keyは"canGround(canSpace)-cost000"の形式を取る ex."canGround-cost700".
  Future<List<MobileSuit>> getMsList() async{
    // 選択済みのマップidとコストをもとにマップのkey(String)を定義する
    String _msListMapKey = "";
    if (BattleRecordEnv.groundMapIdMin <= choosedMapId.value && choosedMapId.value <= BattleRecordEnv.groundMapIdMax) {
      _msListMapKey = "canGround-cost${choosedCost.value}";
    } else if (BattleRecordEnv.spaceMapIdMin <= choosedMapId.value && choosedMapId.value <= BattleRecordEnv.spaceMapIdMax) {
      _msListMapKey = "canSpace-cost${choosedCost.value}";
    }
    // 定義したkeyに対応したデータが取得済みMSリストマップに存在するかチェック
    if  (battleRecordCache.containsKey(_msListMapKey)) {
      msDropdownList = [];
      battleRecordCache[_msListMapKey]!.asMap().forEach((index, ms) {
        Map<int, String> _map = new Map();
        _map[ms.id!] = "${ms.msName} Lv.${ms.msLevel}";
        // if (index == 0) {
        //   choosedMsMap2.value = _map;
        //   choosedMsMap3.value = _map;
        // }
        msDropdownList.add(DropdownMenuItem(
          child: myText.Text(
            "${ms.msName ??= ""} Lv.${ms.msLevel}",
            style: TextStyle(fontSize: 15.0),
          ),
          value: _map,
        ));
      });
      return battleRecordCache[_msListMapKey]!;
    } else {
      MsListRepository mlr = new MsListRepository();
      msList = await mlr.getRecordFindByMapAndCost(mapId: choosedMapId.value, cost: choosedCost.value);
      battleRecordCache[_msListMapKey] = msList;
      msList.asMap().forEach((index, ms) {
        Map<int, String> _map = new Map();
        _map[ms.id!] = "${ms.msName} Lv.${ms.msLevel}";
        // if (index == 0) {
        //   choosedMsMap2.value = _map;
        //   choosedMsMap3.value = _map;
        // }
        msDropdownList.add(DropdownMenuItem(
          child: myText.Text(
            "${ms.msName ??= ""} Lv.${ms.msLevel}",
            style: TextStyle(fontSize: 15.0),
          ),
          value: _map,
        ));
      });
      return battleRecordCache[_msListMapKey]!;
    }
  }
}
