
import 'package:battle_operation2_app/chart_model/mobile_suit_type_win_rate_chart.dart';
import 'package:battle_operation2_app/chart_model/time_frame_win_rate_chart.dart';
import 'package:battle_operation2_app/chart_model/weekdays_win_rate_chart.dart';
import 'package:battle_operation2_app/common_widget/battle_record_view/number_of_sorties_and_win_rate.dart';
import 'package:battle_operation2_app/common_widget/battle_record_view/win_rate_column_chart.dart';
import 'package:battle_operation2_app/common_widget/battle_record_view/win_rate_line_chart.dart';
import 'package:battle_operation2_app/common_widget/battle_record_view/win_rate_pie_chart.dart';
import 'package:battle_operation2_app/common_widget/custom/custom_container.dart';
import 'package:battle_operation2_app/config/enums.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/entity/battle_record.dart';
import 'package:battle_operation2_app/helper/calculation_util.dart';
import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/helper/enum_util.dart';
import 'package:battle_operation2_app/helper/numeric_conversion_util.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AllGroundDataView5 {

  /// レコード数(出撃回数)
  int totalRecordNum = 0;

  /// 勝利数
  int totalWinNum = 0;

  /// 敗北数
  int totalLoseNum = 0;

  /// 勝率, 勝利数/出撃回数*100, 少数第二位まで表示.
  double winRate = 0.0;

  /**
   * MSタイプ別勝率グラフデータ用
   */
  /// 取得レコードのうち強襲機に登場した回数.
  int numberOfRaidUses = 0;

  /// 強襲機に登場し、勝利した回数.
  int winNumWhileUsingRaid = 0;

  /// 強襲機搭乗時の勝率(除法の結果, 100は掛けていない).
  double winRateWhileUsingRaid = 0.0;

  /// 取得レコード汎用機に登場した回数.
  int numberOfGeneralUses = 0;

  /// 汎用機に登場し、勝利した回数.
  int winNumWhileUsingGeneral = 0;

  /// 汎用機搭乗時の勝率(除法の結果, 100は掛けていない).
  double winRateWhileUsingGeneral = 0.0;

  /// 取得レコード支援機に登場した回数.
  int numberOfSupportUses = 0;

  /// 支援機に登場し、勝利した回数.
  int winNumWhileUsingSupport = 0;

  /// 支援機搭乗時の勝率(除法の結果, 100は掛けていない).
  double winRateWhileUsingSupport = 0.0;

  /// MSタイプ別の勝率データを保持するリスト.
  List<MobileSuitTypeWinRateChart> msTypeWinRateData = [];

  /**
   * 時間帯別グラフデータ用
   */
  /// 時間帯毎の出撃回数.
  Map<int, int> numberOfSallyPerHour = {
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
  Map<int, int> numberOfWinPerHour = {
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
  Map<int, int> numberOfSallyPerWeekday = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0
  };
  /// 曜日毎の勝利回数.
  Map<int, int> numberOfWinPerWeekday = {
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
  Map<int, int> numberOfSallyFormation = {};
  /// 編成毎の勝利回数.
  Map<int, int> numberOfWinPerFormation = {};

  /**
   * 味方レート帯別グラフデータ用
   */
  /// 最高レート帯以外の味方の人数毎の出撃回数.
  Map<int, int> numberOfSallyPerNotHighestRankPlayer = {};
  /// 最高レート帯以外の味方の人数毎の勝利回数.
  Map<int, int> numberOfWinPerNotHighestRankPlayer = {};

  /// 自チームが5人だった試合のデータを作成する.
  bool init(List<BattleRecord> records) {
    bool _isNotDataNull = false;
    if (records.isEmpty) {
      return _isNotDataNull;
    } else {
      records.asMap().forEach((index, e) {
        totalRecordNum = records.length;
        bool _isWin = e.winOrLoseResult == 1 ? true : false;
        DateTime _insertDate = DateTimeUtil.unixTimeConvertToDateTime(e.insertDateUnix);
        // 取得した時間(hour)がkeyとしてMapに存在する場合、時間毎の出撃回数を更新する
        int _sallyHour = e.timeFrame;
        int? _sally = numberOfSallyPerHour.containsKey(_sallyHour) ? numberOfSallyPerHour[_sallyHour]! + 1 : null;
        if (_sally != null) {
          numberOfSallyPerHour[_sallyHour] = _sally;
        }
        // 取得した曜日がkeyとしてMapに存在する場合、曜日毎の出撃回数を更新する
        int _weekday = _insertDate.weekday;
        int? _weekdaySally = numberOfSallyPerWeekday.containsKey(_weekday) ? numberOfSallyPerWeekday[_weekday]! + 1 : null;
        if (_weekdaySally != null) {
          numberOfSallyPerWeekday[_weekday] = _weekdaySally;
        }
        // 編成毎の出撃回数を更新する
        int? _formationSally = numberOfSallyFormation.containsKey(e.formation) ? numberOfSallyFormation[e.formation]! + 1 : null;
        if (_formationSally != null) {
          numberOfSallyFormation[e.formation] = _formationSally;
        } else {
          numberOfSallyFormation[e.formation] = 1;
        }
        // 最高レート帯以外の味方の人数毎の出撃回数を更新する
        int? _notHighestRankPlayerSally = numberOfSallyPerNotHighestRankPlayer.containsKey(e.notHighestRankPlayer) ? numberOfSallyPerNotHighestRankPlayer[e.notHighestRankPlayer]! + 1 : null;
        if (_notHighestRankPlayerSally != null) {
          numberOfSallyPerNotHighestRankPlayer[e.notHighestRankPlayer] = _notHighestRankPlayerSally;
        } else {
          numberOfSallyPerNotHighestRankPlayer[e.notHighestRankPlayer] = 1;
        }

        // 試合に勝った場合
        if (_isWin) {
          totalWinNum += 1;
          // MSタイプ毎の出撃回数,勝利数
          switch(EnumUtil.getMobileSuitTypeByNum(e.msTypeId)) {
            case MobileSuitType.Raid:
              numberOfRaidUses += 1;
              winNumWhileUsingRaid += 1;
              break;
            case MobileSuitType.General:
              numberOfGeneralUses += 1;
              winNumWhileUsingGeneral += 1;
              break;
            case MobileSuitType.Support:
              numberOfSupportUses += 1;
              winNumWhileUsingSupport += 1;
              break;
            default :
              break;
          }
          // 時間帯毎の勝利回数を更新 出撃回数のmapとkeyは同一のため,containsチェックは不必要
          if (_sally != null) {
            numberOfWinPerHour[_sallyHour] = numberOfWinPerHour[_sallyHour]! + 1;
          }
          // 曜日毎の勝利回数を更新 出撃回数のmapとkeyは同一のため,containsチェックは不必要
          if (_weekdaySally != null) {
            numberOfWinPerWeekday[_weekday] = numberOfWinPerWeekday[_weekday]! + 1;
          }
          // 編成毎の勝利回数を更新 keyが存在する場合はvalueを1増加,存在しない場合はvalue1を新たに追加
          if (numberOfWinPerFormation.containsKey(e.formation)) {
            numberOfWinPerFormation[e.formation] = numberOfWinPerFormation[e.formation]! + 1;
          } else {
            numberOfWinPerFormation[e.formation] = 1;
          }
          // 最高レート帯以外の味方の人数毎の勝利回数を更新 keyが存在する場合はvalueを1増加,存在しない場合はvalue1を新たに追加
          if (numberOfWinPerNotHighestRankPlayer.containsKey(e.notHighestRankPlayer)) {
            numberOfWinPerNotHighestRankPlayer[e.notHighestRankPlayer] = numberOfWinPerNotHighestRankPlayer[e.notHighestRankPlayer]! + 1;
          } else {
            numberOfWinPerNotHighestRankPlayer[e.notHighestRankPlayer] = 1;
          }
        // 試合に負けた場合
        } else {
          totalLoseNum += 1;
          // MSタイプ毎の出撃回数
          switch(EnumUtil.getMobileSuitTypeByNum(e.msTypeId)) {
            case MobileSuitType.Raid:
              numberOfRaidUses += 1;
              break;
            case MobileSuitType.General:
              numberOfGeneralUses += 1;
              break;
            case MobileSuitType.Support:
              numberOfSupportUses += 1;
              break;
            default :
              break;
          }
        }
      });
      // 勝率などを計算する
      winRate = CalculationUtil.division(totalWinNum, totalRecordNum) ?? 0;
      return true;
    }
  }

  /// 地上かつプレイヤー数5人の場合の画面を返す.
  Widget allGroundDataViewBody() {
    return CustomContainer(
      leftMargin: ScreenEnv.deviceWidth * 0.02,
      rightMargin: ScreenEnv.deviceWidth * 0.02,
      widget: Column(
        children: <Widget>[
          _topInformation(),
          _msTypeWinRateCircularChartFive(),
          _timeFrameChart(),
          _weekdaysChart()
        ],
      ),
    );
  }

  /// 出撃回数と勝率を表示するエリアを返す.
  Widget _topInformation() {
    return NumberOfSortiesAndWinRate(numberOfSortie: totalRecordNum,
      numberOfWin: totalWinNum,
      numberOfLose: totalLoseNum,
      winRate: winRate
    );
  }

  /// MSタイプ毎の勝率をもとに作成した円グラフを返す.
  Widget _msTypeWinRateCircularChartFive() {
    List<MobileSuitTypeWinRateChart> _data = [];
    //if (msTypeWinRateData.isEmpty) {
      // 強襲,汎用,支援の勝率を計算し、モデルクラスのインスタンスをそれぞれ作成する
      winRateWhileUsingRaid = CalculationUtil.division(winNumWhileUsingRaid, numberOfRaidUses) ?? 0;
      winRateWhileUsingGeneral = CalculationUtil.division(winNumWhileUsingGeneral, numberOfGeneralUses) ?? 0;
      winRateWhileUsingSupport = CalculationUtil.division(winNumWhileUsingSupport, numberOfSupportUses) ?? 0;
      var raidChart = MobileSuitTypeWinRateChart(
          x: EnumUtil.getMobileSuitType(MobileSuitType.Raid),
          y: winRateWhileUsingRaid*100.floor(),
          pointColor: Color.fromRGBO(203,0,0,1),
          text: "${EnumUtil.getMobileSuitType(MobileSuitType.Raid)}:${NumericConversionUtil.numConvertToPercentage(winRateWhileUsingRaid)}"
      );
      _data.add(raidChart);
      var generalChart = MobileSuitTypeWinRateChart(
          x: EnumUtil.getMobileSuitType(MobileSuitType.General),
          y: winRateWhileUsingGeneral*100.floor(),
          pointColor: Color.fromRGBO(0,101,203,1),
          text: "${EnumUtil.getMobileSuitType(MobileSuitType.General)}:${NumericConversionUtil.numConvertToPercentage(winRateWhileUsingGeneral)}"
      );
      _data.add(generalChart);
      var supportChart = MobileSuitTypeWinRateChart(
          x: EnumUtil.getMobileSuitType(MobileSuitType.Support),
          y: winRateWhileUsingSupport*100.floor(),
          pointColor: Color.fromRGBO(203,203,0,1),
          text: "${EnumUtil.getMobileSuitType(MobileSuitType.Support)}:${NumericConversionUtil.numConvertToPercentage(winRateWhileUsingSupport)}"
      );
      _data.add(supportChart);
    //} else {
    //  _data = msTypeWinRateData;
    //}
    return WinRatePieChart(title: "MS種別毎勝率", listData: _data);
  }

  /// 時間帯別の勝率をもとに作成した折れ線グラフを返す.
  Widget _timeFrameChart() {
    List<TimeFrameWinRateChart> _data = [];
    numberOfSallyPerHour.forEach((timeFrame, numberOfSallyPerHour) {
      int numberOfWin = numberOfWinPerHour[timeFrame] ?? 0;
      double winRate = CalculationUtil.division(numberOfWin, numberOfSallyPerHour) ?? 0;
      TimeFrameWinRateChart _chartData = TimeFrameWinRateChart(
          timeFrame,
          (winRate*100).floor(),
          numberOfSallyPerHour != 0 ? Colors.green : Colors.white10);
      _data.add(_chartData);
    });
    return WinRateLineChart(listData: _data);
  }

  /// 曜日別の勝率をもとに作成した棒グラフを返す.
  Widget _weekdaysChart() {
    List<WeekdaysWinRateChart> _data = [];
    numberOfSallyPerWeekday.forEach((weekdays, numberOfSallyPerWeekday) {
      int numberOfWin = numberOfWinPerWeekday[weekdays] ?? 0;
      double winRate = CalculationUtil.division(numberOfWin, numberOfSallyPerWeekday) ?? 0;
      WeekdaysWinRateChart _chartData = WeekdaysWinRateChart(
          DateTimeUtil.weekdayNumConvertToString(weekdays), (winRate*100).floor(),
          pointColor: DateTimeUtil.weekdayNumConvertToColor(weekdays)
      );
      _data.add(_chartData);
    });
    return WinRateColumnChart(listData: _data,);
  }
}