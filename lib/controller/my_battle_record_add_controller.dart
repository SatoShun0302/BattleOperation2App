import 'package:battle_operation2_app/config/battle_record_env.dart';
import 'package:battle_operation2_app/config/error_message.dart';
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

  /**
   * record_add2画面で使用する
   */
  /// 選択されたMSのid (自機は1,僚機は2~6)
  RxInt choosedMsId1 = 0.obs;
  RxInt choosedMsId2 = 0.obs;
  RxInt choosedMsId3 = 0.obs;
  RxInt choosedMsId4 = 0.obs;
  RxInt choosedMsId5 = 0.obs;
  RxInt choosedMsId6 = 0.obs;
  RxMap choosedMsMap1 = RxMap();
  RxMap choosedMsMap2 = RxMap();
  RxMap choosedMsMap3 = RxMap();
  RxMap choosedMsMap4 = RxMap();
  RxMap choosedMsMap5 = RxMap();
  RxMap choosedMsMap6 = RxMap();


  /// 選択されたチームサイド
  RxString choosedSide = BattleRecordEnv.teamSideA.obs;

  /// 勝敗予想
  RxInt choosedPrediction = BattleRecordEnv.win.obs;

  /**
   * record_add3画面で使用する
   */
  /// DBに登録されている最新のレート textFieldで使用するためString型にする
  RxString currentRateNum = "1000".obs;

  /// 検索時点の最新レートを保持しておく ユーザーの操作によって変更しない
  String _tempCurrentRateNum = "";

  /// 勝敗結果　チーム
  RxInt winOrLoseResultTeam = BattleRecordEnv.win.obs;

  /// 勝敗結果　ライバル
  RxInt winOrLoseResultRival = BattleRecordEnv.win.obs;

  /// 総合個人順位 2桁整数 textFieldで使用するためString型にする
  RxString overallRanking = "".obs;

  /// 個人スコア 5桁整数 textFieldで使用するためString型にする
  RxString personalScoreRanking = "".obs;
  RxString personalScore = "".obs;

  /// アシストスコア 5桁整数 textFieldで使用するためString型にする
  RxString assistScoreRanking = "".obs;
  RxString assistScore = "".obs;

  /// 与ダメージ 6桁整数 textFieldで使用するためString型にする
  RxString dealDamageRanking = "".obs;
  RxString dealDamage = "".obs;

  /// 陽動 小数点第二位までの少数 textFieldで使用するためString型にする
  RxString feintRanking = "".obs;
  RxString feint = "".obs;

  /// MS撃破 2桁整数 textFieldで使用するためString型にする
  RxString msDefeatRanking = "".obs;
  RxString msDefeat = "".obs;

  /// MS損失 2桁整数 textFieldで使用するためString型にする
  RxString msLossRanking = "".obs;
  RxString msLoss = "".obs;

  /// 追撃アシスト 6桁整数 textFieldで使用するためString型にする
  RxString pursuitAssistRanking = "".obs;
  RxString pursuitAssist = "".obs;

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

  /// 襲撃前情報入力画面１を開いた際および戦績登録完了後に、特定の変数を初期化する.
  ///
  /// 選択済マップ,コスト,対戦人数については連戦を想定し初期化しない.
  void init() {
    // 出撃前情報入力画面２で使用する変数を初期化
    choosedMsId1.value = 0;
    choosedMsId2.value = 0;
    choosedMsId3.value = 0;
    choosedMsId4.value = 0;
    choosedMsId5.value = 0;
    choosedMsId6.value = 0;
    choosedMsMap1.value = {};
    choosedMsMap2.value = {};
    choosedMsMap3.value = {};
    choosedMsMap4.value = {};
    choosedMsMap5.value = {};
    choosedMsMap6.value = {};
    choosedSide = BattleRecordEnv.teamSideA.obs;
    choosedPrediction = BattleRecordEnv.win.obs;
  }

  /// 出撃準備画面１で使用する、マップ一覧を取得する.
  Future<void> getMapList() async {
    if (mapDropdownList.isEmpty) {
      MapListRepository mlr = new MapListRepository();
      List<MapList> mapLists = await mlr.getRecord();
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
  Future<void> getCostList() async {
    if (costDropdownList.isEmpty) {
      CostListRepository clr = new CostListRepository();
      List<Cost> costList = await clr.getRecord();
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
          // 1チームの人数と合わせるためにindexに5をプラスする(レートの最低人数が5人の場合)
          choosedNumberOfPlayer.value = index + 5;
        }
        numberOfPlayerList.add(DropdownMenuItem(
          child: myText.Text(
            value,
            style: TextStyle(fontSize: 15.0),
          ),
          value: index + 5,
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

  /// record_add1の次へボタン押下時にバリデーションを行う.
  ///
  /// マップ,コスト,対戦人数未入力でないかを確認.
  /// @return List<String> errorMessage: エラーメッセージリスト
  List<String> recordAdd1Validate() {
    List<String> errorMessage = [];
    if (choosedMapId.value == 0) {
      errorMessage.add(ErrorMessage.mapIdUnselected);
    }
    if (choosedCost.value == 0) {
      errorMessage.add(ErrorMessage.costUnselected);
    }
    if (choosedNumberOfPlayer.value == 0) {
      errorMessage.add(ErrorMessage.numberOfPlayerUnselected);
    }
    return errorMessage;
  }

  /// record_add2の出撃ボタン押下時にバリデーションを行う.
  ///
  /// 自機、僚機が未選択でないかを確認.
  /// @return List<String> errorMessage: エラーメッセージリスト
  List<String> recordAdd2Validate() {
    List<String> errorMessage = [];
    if (choosedMsId1.value == 0) {
      errorMessage.add(ErrorMessage.ownMsUnselected);
    }
    if (choosedMsId2.value == 0) {
      errorMessage.add(ErrorMessage.wingmanUnselected);
    }
    if (choosedMsId3.value == 0) {
      errorMessage.add(ErrorMessage.wingmanUnselected);
    }
    if (choosedMsId4.value == 0) {
      errorMessage.add(ErrorMessage.wingmanUnselected);
    }
    if (choosedMsId5.value == 0) {
      errorMessage.add(ErrorMessage.wingmanUnselected);
    }
    // 対戦人数が12人（1チーム6人）の場合のみバリデーションを行う
    if (choosedNumberOfPlayer.value == 6) {
      if (choosedMsId6.value == 0) {
        errorMessage.add(ErrorMessage.wingmanUnselected);
      }
    }
    // 僚機未選択メッセージが重複している場合は削除する
    errorMessage = errorMessage.toSet().toList();
    return errorMessage;
  }

  /// record_add3のデータ登録ボタン押下時にバリデーションを行う.
  ///
  /// レート及び各種戦績が未入力でないかを確認.
  /// @return List<String> errorMessage: エラーメッセージリスト
  List<String> recordAdd3Validate() {
    List<String> errorMessage = [];
    int _rateDiff = 0;
    if (currentRateNum.isNotEmpty && int.tryParse(_tempCurrentRateNum) != null) {
      /**
       * レートが未入力でない、かつレートの初期値取得に成功していた場合のみ増減値を計算.
       * currentRateNumはウィジェット側でバリデート済み.
       * _tempCurrentRateNumは最新レートをDBから取得する際に数値であることを確認済み.
       */
      _rateDiff = int.tryParse(currentRateNum.value)! - int.tryParse(_tempCurrentRateNum)!;
    } else if (currentRateNum.value.isEmpty) {
      errorMessage.add(ErrorMessage.rateNotEntered);
    }
    /**
     * 以下のvalueは、ウィジェット側で数値変換可能かを判断し変換できる場合のみ代入済み
     */
    // 総合個人順位
    if (overallRanking.value.isEmpty) {
      errorMessage.add(ErrorMessage.overallRankingNotEntered);
    } else {
      if (int.tryParse(overallRanking.value)! <= 0) {
        errorMessage.add("総合個人順位の${ErrorMessage.illegalInputValue}");
      }
    }
    // 個人スコア
    if (personalScoreRanking.value.isEmpty) {
      errorMessage.add(ErrorMessage.personalScoreRankingNotEntered);
    } else {
      if (int.tryParse(personalScoreRanking.value)! <= 0) {
        errorMessage.add("個人スコア順位の${ErrorMessage.illegalInputValue}");
      }
    }
    if (personalScore.value.isEmpty) {
      errorMessage.add(ErrorMessage.personalScoreNotEntered);
    } else {
      if (int.tryParse(personalScore.value)! <= -1) {
        errorMessage.add("個人スコアの${ErrorMessage.illegalInputValue}");
      }
    }
    // アシストスコア
    if (assistScoreRanking.value.isEmpty) {
      errorMessage.add(ErrorMessage.assistScoreRankingNotEntered);
    } else {
      if (int.tryParse(assistScoreRanking.value)! <= 0) {
        errorMessage.add("アシストスコア順位の${ErrorMessage.illegalInputValue}");
      }
    }
    if (assistScore.value.isEmpty) {
      errorMessage.add(ErrorMessage.assistScoreNotEntered);
    } else {
      if (int.tryParse(assistScore.value)! <= -1) {
        errorMessage.add("アシストスコアの${ErrorMessage.illegalInputValue}");
      }
    }
    // 与ダメージ
    if (dealDamageRanking.value.isEmpty) {
      errorMessage.add(ErrorMessage.dealDamageRankingNotEntered);
    } else {
      if (int.tryParse(dealDamageRanking.value)! <= 0) {
        errorMessage.add("与ダメージ順位の${ErrorMessage.illegalInputValue}");
      }
    }
    if (dealDamage.value.isEmpty) {
      errorMessage.add(ErrorMessage.dealDamageNotEntered);
    } else {
      if (int.tryParse(dealDamage.value)! <= -1) {
        errorMessage.add("与ダメージの${ErrorMessage.illegalInputValue}");
      }
    }
    // 陽動
    if (feintRanking.value.isEmpty) {
      errorMessage.add(ErrorMessage.feintRankingNotEntered);
    } else {
      if (double.tryParse(feintRanking.value)! <= 0) {
        errorMessage.add("陽動順位の${ErrorMessage.illegalInputValue}");
      }
    }
    if (feint.value.isEmpty) {
      errorMessage.add(ErrorMessage.feintNotEntered);
    } else {
      if (double.tryParse(feint.value)! <= -1) {
        errorMessage.add("陽動の${ErrorMessage.illegalInputValue}");
      }
    }
    // MS撃破
    if (msDefeatRanking.value.isEmpty) {
      errorMessage.add(ErrorMessage.msDefeatRankingNotEntered);
    } else {
      if (int.tryParse(msDefeatRanking.value)! <= 0) {
        errorMessage.add("MS撃破順位の${ErrorMessage.illegalInputValue}");
      }
    }
    if (msDefeat.value.isEmpty) {
      errorMessage.add(ErrorMessage.msDefeatNotEntered);
    } else {
      if (int.tryParse(msDefeat.value)! <= -1) {
        errorMessage.add("MS撃破の${ErrorMessage.illegalInputValue}");
      }
    }
    // MS損失
    if (msLossRanking.value.isEmpty) {
      errorMessage.add(ErrorMessage.msLossRankingNotEntered);
    } else {
      if (int.tryParse(msLossRanking.value)! <= 0) {
        errorMessage.add("MS損失順位の${ErrorMessage.illegalInputValue}");
      }
    }
    if (msLoss.value.isEmpty) {
      errorMessage.add(ErrorMessage.msLossNotEntered);
    } else {
      if (int.tryParse(msLoss.value)! <= -1) {
        errorMessage.add("MS損失の${ErrorMessage.illegalInputValue}");
      }
    }
    // 追撃アシスト
    if (pursuitAssistRanking.value.isEmpty) {
      errorMessage.add(ErrorMessage.pursuitAssistRankingNotEntered);
    } else {
      if (int.tryParse(pursuitAssistRanking.value)! <= 0) {
        errorMessage.add("追撃アシスト順位の${ErrorMessage.illegalInputValue}");
      }
    }
    if (pursuitAssist.value.isEmpty) {
      errorMessage.add(ErrorMessage.pursuitAssistNotEntered);
    } else {
      if (int.tryParse(pursuitAssist.value)! <= -1) {
        errorMessage.add("追撃アシストの${ErrorMessage.illegalInputValue}");
      }
    }
    return errorMessage;
  }

  /// record_add3の戦績登録ボタン押下時に使用する.
  ///
  /// 戦績モデルクラスにコントローラーの変数を代入し、戦績記録テーブルへinsertする.
  /// @return isSuccess: insert処理に成功したか否かのフラグ,デフォルトはfalse.
  bool submit() {
    bool _isSuccess = false;
    return _isSuccess;
  }
}
