import 'package:battle_operation2_app/common_widget/battle_record_view/number_of_sorties_and_win_rate.dart';
import 'package:battle_operation2_app/config/enums.dart';
import 'package:battle_operation2_app/entity/battle_record.dart';
import 'package:battle_operation2_app/helper/calculation_util.dart';
import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/helper/enum_util.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

///
class FocusOnMapView {
  /// レコード数(出撃回数)
  int totalRecordNum = 0;

  /// 勝利数
  int totalWinNum = 0;

  /// 敗北数
  int totalLoseNum = 0;

  /// 勝率.
  double winRate = 0.0;

  /// チームがAの場合の出撃回数.
  int teamARecordNum = 0;

  /// チームがBの場合の出撃回数.
  int teamBRecordNum = 0;

  /// チームがAの場合の勝利回数.
  int teamAWinNum = 0;

  /// チームがBの場合の勝利回数.
  int teamBWinNum = 0;

  /// チームがAの場合の勝率.
  double teamAWinRate = 0.0;

  /// チームがBの場合の勝率.
  double teamBWinRate = 0.0;

  /**
   * MSタイプ別勝率グラフデータ用
   */

  /// コスト毎の強襲出撃回数.
  Map<int, int> numberOfSallyRaidPerCost = {};

  /// コスト毎の強襲勝利回数.
  Map<int, int> numberOfWinRaidPerCost = {};

  /// コスト毎の汎用出撃回数.
  Map<int, int> numberOfSallyGeneralPerCost = {};

  /// コスト毎の汎用勝利回数.
  Map<int, int> numberOfWinGeneralPerCost = {};

  /// コスト毎の支援出撃回数.
  Map<int, int> numberOfSallySupportPerCost = {};

  /// コスト毎の支援勝利回数.
  Map<int, int> numberOfWinSupportPerCost = {};

  /**
   * 編成別グラフデータ用
   */

  /// 編成毎の出撃回数.
  Map<int, Map<int, int>> numberOfSallyFormationPerCost = {};

  /// 編成毎の勝利回数.
  Map<int, Map<int, int>> numberOfWinFormationPerCost = {};

  /// 試合のデータを作成する.
  bool init(List<BattleRecord> records) {
    bool _isNotDataNull = false;
    if (records.isEmpty) {
      return _isNotDataNull;
    } else {
      records.asMap().forEach((index, e) {
        totalRecordNum = records.length;
        bool _isWin = e.winOrLoseResult == 1 ? true : false;
        int _cost = e.cost;
        DateTime _insertDate =
            DateTimeUtil.unixTimeConvertToDateTime(e.insertDateUnix);
        // チームサイド毎の出撃回数を更新する
        if (e.side == "A") {
          teamARecordNum += 1;
        } else if (e.side == "B") {
          teamBRecordNum += 1;
        }
        // 編成毎の出撃回数を更新する
        Map<int, int> _numberOfSallyFormation =
            numberOfSallyFormationPerCost.containsKey(_cost)
                ? numberOfSallyFormationPerCost[_cost]!
                : {};
        int? _formationSally = _numberOfSallyFormation.containsKey(e.formation)
            ? _numberOfSallyFormation[e.formation]! + 1
            : null;
        if (_formationSally != null) {
          _numberOfSallyFormation[e.formation] = _formationSally;
        } else {
          _numberOfSallyFormation[e.formation] = 1;
        }
        numberOfSallyFormationPerCost[_cost] = _numberOfSallyFormation;

        // 試合に勝った場合
        if (_isWin) {
          totalWinNum += 1;
          // MSタイプ毎の出撃回数,勝利数を更新
          switch (EnumUtil.getMobileSuitTypeByNum(e.msTypeId)) {
            case MobileSuitType.Raid:
              int _numberOfRaidUses =
                  numberOfSallyRaidPerCost.containsKey(_cost)
                      ? numberOfSallyRaidPerCost[_cost]! + 1
                      : 1;
              numberOfSallyRaidPerCost[_cost] = _numberOfRaidUses;
              int _winNumWhileUsingRaid =
                  numberOfWinRaidPerCost.containsKey(_cost)
                      ? numberOfWinRaidPerCost[_cost]! + 1
                      : 1;
              numberOfWinRaidPerCost[_cost] = _winNumWhileUsingRaid;
              break;
            case MobileSuitType.General:
              int _numberOfGeneralUses =
                  numberOfSallyGeneralPerCost.containsKey(_cost)
                      ? numberOfSallyGeneralPerCost[_cost]! + 1
                      : 1;
              numberOfSallyGeneralPerCost[_cost] = _numberOfGeneralUses;
              int _winNumWhileUsingGeneral =
                  numberOfWinGeneralPerCost.containsKey(_cost)
                      ? numberOfWinGeneralPerCost[_cost]! + 1
                      : 1;
              numberOfWinGeneralPerCost[_cost] = _winNumWhileUsingGeneral;
              break;
            case MobileSuitType.Support:
              int _numberOfSupportUses =
                  numberOfSallySupportPerCost.containsKey(_cost)
                      ? numberOfSallySupportPerCost[_cost]! + 1
                      : 1;
              numberOfSallySupportPerCost[_cost] = _numberOfSupportUses;
              int _winNumWhileUsingSupport =
                  numberOfWinSupportPerCost.containsKey(_cost)
                      ? numberOfWinSupportPerCost[_cost]! + 1
                      : 1;
              numberOfWinSupportPerCost[_cost] = _winNumWhileUsingSupport;
              break;
            default:
              break;
          }
          // チームサイド別の勝利回数を更新
          if (e.side == "A") {
            teamAWinNum += 1;
          } else if (e.side == "B") {
            teamBWinNum += 1;
          }
          // 編成毎の勝利回数を更新 keyが存在する場合はvalueを1増加,存在しない場合はvalue1を新たに追加
          Map<int, int> _numberOfWinFormation =
              numberOfWinFormationPerCost.containsKey(_cost)
                  ? numberOfWinFormationPerCost[_cost]!
                  : {};
          if (_numberOfWinFormation.containsKey(e.formation)) {
            _numberOfWinFormation[e.formation] =
                _numberOfWinFormation[e.formation]! + 1;
          } else {
            _numberOfWinFormation[e.formation] = 1;
          }
          numberOfWinFormationPerCost[_cost] = _numberOfWinFormation;

          // 試合に負けた場合
        } else {
          totalLoseNum += 1;
          // MSタイプ毎の出撃回数
          switch (EnumUtil.getMobileSuitTypeByNum(e.msTypeId)) {
            case MobileSuitType.Raid:
              int _numberOfRaidUses =
                  numberOfSallyRaidPerCost.containsKey(_cost)
                      ? numberOfSallyRaidPerCost[_cost]! + 1
                      : 1;
              numberOfSallyRaidPerCost[_cost] = _numberOfRaidUses;
              break;
            case MobileSuitType.General:
              int _numberOfGeneralUses =
                  numberOfSallyGeneralPerCost.containsKey(_cost)
                      ? numberOfSallyGeneralPerCost[_cost]! + 1
                      : 1;
              numberOfSallyGeneralPerCost[_cost] = _numberOfGeneralUses;
              break;
            case MobileSuitType.Support:
              int _numberOfSupportUses =
                  numberOfSallySupportPerCost.containsKey(_cost)
                      ? numberOfSallySupportPerCost[_cost]! + 1
                      : 1;
              numberOfSallySupportPerCost[_cost] = _numberOfSupportUses;
              break;
            default:
              break;
          }
        }
      });
      // 勝率を計算する
      winRate = CalculationUtil.division(totalWinNum, totalRecordNum) ?? 0;
      teamAWinRate = CalculationUtil.division(teamAWinNum, teamARecordNum) ?? 0;
      teamBWinRate = CalculationUtil.division(teamBWinNum, teamBRecordNum) ?? 0;
      return true;
    }
  }

  /// 出撃回数と勝率を表示するエリアを返す.
  Widget topInformation() {
    return NumberOfSortiesAndWinRate(
      numberOfSortie: totalRecordNum,
      numberOfWin: totalWinNum,
      numberOfLose: totalLoseNum,
      winRate: winRate,
      teamAWinRate: teamAWinRate,
      teamBWinRate: teamBWinRate,
    );
  }
}
