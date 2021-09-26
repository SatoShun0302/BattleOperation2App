import 'package:battle_operation2_app/chart_model/mobile_suit_type_win_rate_chart.dart';
import 'package:battle_operation2_app/common_widget/battle_record_view/win_rate_pie_chart.dart';
import 'package:battle_operation2_app/config/enums.dart';
import 'package:battle_operation2_app/entity/battle_record.dart';
import 'package:battle_operation2_app/helper/calculation_util.dart';
import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/helper/enum_util.dart';
import 'package:battle_operation2_app/helper/numeric_conversion_util.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AllGroundDataView6 {

  /// レコード数(出撃回数)
  int totalRecordNumSix = 0;

  /// 勝利数
  int totalWinNumSix = 0;

  /// 敗北数
  int totalLoseNumSix = 0;

  /// 勝率, 勝利数/出撃回数*100, 少数第二位まで表示.
  double winRateSix = 0.0;

  /**
   * MSタイプ別勝率グラフデータ用
   */
  /// 取得レコードのうち強襲機に登場した回数.
  int numberOfRaidUsesSix = 0;

  /// 強襲機に登場し、勝利した回数.
  int winNumWhileUsingRaidSix = 0;

  /// 強襲機搭乗時の勝率(除法の結果, 100は掛けていない).
  double winRateWhileUsingRaidSix = 0.0;

  /// 取得レコード汎用機に登場した回数.
  int numberOfGeneralUsesSix = 0;

  /// 汎用機に登場し、勝利した回数.
  int winNumWhileUsingGeneralSix = 0;

  /// 汎用機搭乗時の勝率(除法の結果, 100は掛けていない).
  double winRateWhileUsingGeneralSix = 0.0;

  /// 取得レコード支援機に登場した回数.
  int numberOfSupportUsesSix = 0;

  /// 支援機に登場し、勝利した回数.
  int winNumWhileUsingSupportSix = 0;

  /// 支援機搭乗時の勝率(除法の結果, 100は掛けていない).
  double winRateWhileUsingSupportSix = 0.0;

  /// MSタイプ別の勝率データを保持するリスト.
  List<MobileSuitTypeWinRateChart> msTypeWinRateDataSix = [];

  /**
   * 時間帯別グラフデータ用
   */
  /// 時間帯毎の出撃回数.
  Map<int, int> numberOfSallyPerHourSix = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0,
    11: 0,
    12: 0,
    13: 0,
    14: 0,
    15: 0,
    16: 0,
    17: 0,
    18: 0,
    19: 0,
    20: 0,
    21: 0,
    22: 0,
    23: 0
  };
  /// 時間帯毎の勝利回数.
  Map<int, int> numberOfWinPerHourSix = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0,
    11: 0,
    12: 0,
    13: 0,
    14: 0,
    15: 0,
    16: 0,
    17: 0,
    18: 0,
    19: 0,
    20: 0,
    21: 0,
    22: 0,
    23: 0
  };

  /**
   * 曜日別グラフデータ用
   */
  /// 曜日毎の出撃回数.
  Map<int, int> numberOfSallyPerWeekdaySix = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0
  };
  /// 曜日毎の勝利回数.
  Map<int, int> numberOfWinPerWeekdaySix = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0
  };

  /**
   * 編成別グラフデータ用
   */
  /// 編成毎の出撃回数.
  Map<int, int> numberOfSallyFormationSix = {};
  /// 編成毎の勝利回数.
  Map<int, int> numberOfWinPerFormationSix = {};

  /**
   * 味方レート帯別グラフデータ用
   */
  /// 最高レート帯以外の味方の人数毎の出撃回数.
  Map<int, int> numberOfSallyPerNotHighestRankPlayerSix = {};
  /// 最高レート帯以外の味方の人数毎の勝利回数.
  Map<int, int> numberOfWinPerNotHighestRankPlayerSix = {};

  /// 自チームが6人だった試合のデータを作成する.
  bool init(List<BattleRecord> records) {
    bool _isNotDataNull = false;
    if (records.isEmpty) {
      return _isNotDataNull;
    } else {
      records.asMap().forEach((index, e) {
        totalRecordNumSix = records.length;
        bool _isWin = e.winOrLoseResult == 1 ? true : false;
        DateTime _insertDate = DateTimeUtil.unixTimeConvertToDateTime(e.insertDateUnix);
        // 取得した時間(hour)がkeyとしてMapに存在する場合、時間毎の出撃回数を更新する
        int _sallyHour = e.timeFrame;
        int? _sally = numberOfSallyPerHourSix.containsKey(_sallyHour) ? numberOfSallyPerHourSix[_sallyHour]! + 1 : null;
        if (_sally != null) {
          numberOfSallyPerHourSix[_sallyHour] = _sally;
        }
        // 取得した曜日がkeyとしてMapに存在する場合、曜日毎の出撃回数を更新する
        int _weekday = _insertDate.weekday;
        int? _weekdaySally = numberOfSallyPerWeekdaySix.containsKey(_weekday) ? numberOfSallyPerWeekdaySix[_weekday] : null;
        if (_weekdaySally != null) {
          numberOfSallyPerWeekdaySix[_weekday] = _weekdaySally;
        }
        // 編成毎の出撃回数を更新する
        int? _formationSally = numberOfSallyFormationSix.containsKey(e.formation) ? numberOfSallyFormationSix[e.formation]! + 1 : null;
        if (_formationSally != null) {
          numberOfSallyFormationSix[e.formation] = _formationSally;
        } else {
          numberOfSallyFormationSix[e.formation] = 1;
        }
        // 最高レート帯以外の味方の人数毎の出撃回数を更新する
        int? _notHighestRankPlayerSally = numberOfSallyPerNotHighestRankPlayerSix.containsKey(e.notHighestRankPlayer) ? numberOfSallyPerNotHighestRankPlayerSix[e.notHighestRankPlayer]! + 1 : null;
        if (_notHighestRankPlayerSally != null) {
          numberOfSallyPerNotHighestRankPlayerSix[e.notHighestRankPlayer] = _notHighestRankPlayerSally;
        } else {
          numberOfSallyPerNotHighestRankPlayerSix[e.notHighestRankPlayer] = 1;
        }

        // 試合に勝った場合
        if (_isWin) {
          totalWinNumSix += 1;
          // MSタイプ毎の出撃回数,勝利数
          switch(EnumUtil.getMobileSuitTypeByNum(e.msTypeId)) {
            case MobileSuitType.Raid:
              numberOfRaidUsesSix += 1;
              winNumWhileUsingRaidSix += 1;
              break;
            case MobileSuitType.General:
              numberOfGeneralUsesSix += 1;
              winNumWhileUsingGeneralSix += 1;
              break;
            case MobileSuitType.Support:
              numberOfSupportUsesSix += 1;
              winNumWhileUsingSupportSix += 1;
              break;
            default :
              break;
          }
          // 時間帯毎の勝利回数を更新
          if (_sally != null) {
            numberOfWinPerHourSix[_sallyHour] = numberOfWinPerHourSix[_sallyHour]! + 1;
          }
          // 曜日毎の勝利回数を更新
          if (_weekdaySally != null) {
            numberOfWinPerWeekdaySix[_weekday] = numberOfWinPerWeekdaySix[_weekday]! + 1;
          }
          // 編成毎の勝利回数を更新 keyが存在する場合はvalueを1増加,存在しない場合はvalue1を新たに追加
          if (numberOfWinPerFormationSix.containsKey(e.formation)) {
            numberOfWinPerFormationSix[e.formation] = numberOfWinPerFormationSix[e.formation]! + 1;
          } else {
            numberOfWinPerFormationSix[e.formation] = 1;
          }
          // 最高レート帯以外の味方の人数毎の勝利回数を更新 keyが存在する場合はvalueを1増加,存在しない場合はvalue1を新たに追加
          if (numberOfWinPerNotHighestRankPlayerSix.containsKey(e.notHighestRankPlayer)) {
            numberOfWinPerNotHighestRankPlayerSix[e.notHighestRankPlayer] = numberOfWinPerNotHighestRankPlayerSix[e.notHighestRankPlayer]! + 1;
          } else {
            numberOfWinPerNotHighestRankPlayerSix[e.notHighestRankPlayer] = 1;
          }
          // 試合に負けた場合
        } else {
          totalLoseNumSix += 1;
        }
      });
      return true;;
    }
  }

  /// (自チームが6人の場合の)MSタイプ毎の勝率をもとに作成した円グラフを返す.
  Widget? msTypeWinRateCircularChartSix() {
    List<MobileSuitTypeWinRateChart> _data = [];
    if (msTypeWinRateDataSix.isEmpty) {
      // 強襲,汎用,支援の勝率を計算し、モデルクラスのインスタンスをそれぞれ作成する
      winRateWhileUsingRaidSix = CalculationUtil.division(winNumWhileUsingRaidSix, numberOfRaidUsesSix) ?? 0;
      winRateWhileUsingGeneralSix = CalculationUtil.division(winNumWhileUsingGeneralSix, numberOfGeneralUsesSix) ?? 0;
      winRateWhileUsingSupportSix = CalculationUtil.division(winNumWhileUsingSupportSix, numberOfSupportUsesSix) ?? 0;
      MobileSuitTypeWinRateChart(
          x: EnumUtil.getMobileSuitType(MobileSuitType.Raid),
          y: winRateWhileUsingRaidSix*100.floor(),
          text: NumericConversionUtil.numConvertToPercentage(winRateWhileUsingRaidSix)
      );
    } else {
      _data = msTypeWinRateDataSix;
    }
    return WinRatePieChart(title: "MS種別毎勝率", listData: _data);
  }
}