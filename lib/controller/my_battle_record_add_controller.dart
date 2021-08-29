import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
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
  /// keyは"canGround0-canSpace0-cost000"の形式を取る ex."canGround1-canSpace0-cost700".
  RxMap<String, MyBattleRecordSingle> battleRecordCache =
      new Map<String, MyBattleRecordSingle>().obs;

  /// マップのドロップダウンリスト
  List<DropdownMenuItem<int>> mapDropdownList = [];

  /// 選択されたマップのid　地上は1001~1999　宇宙は2001~2999
  RxInt choosedMapId = 0.obs;

  /// コストリスト
  List<int> costList = [];

  /// MSタイプリスト
  Map<int, String> msTypeList = new Map();

  /// MSリスト
  List<MobileSuit> msList = [];

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

  /// 出撃準備画面１で使用する、マップ一覧を取得する.
  Future<void> getMapList() async {
    /* マップ一覧*/
    MapListRepository mlr = new MapListRepository();
    List<MapList> mapLists = await mlr.getRecord();
    mapDropdownList = [];
    mapLists.asMap().forEach((index, mapList) {
      if (index == 0) {
        choosedMapId.value = mapList.mapId!;
      };
      mapDropdownList.add(DropdownMenuItem(
        child: myText.Text(
          mapList.mapName ??= "",
          style: TextStyle(fontSize: 15.0),
        ),
        value: mapList.mapId,
      ));
    });
  }

  /// 出撃準備画面１で使用する、コスト一覧を取得する.


  /// 出撃準備画面２で使用する、MS一覧を取得する.
  Future<void> getMsList() async{
    MsListRepository mlr = new MsListRepository();
    msList = await mlr.getRecordFindByMapAndCost(mapId: choosedMapId.value, cost: choosedCost.value);
    print(msList);
  }
}
