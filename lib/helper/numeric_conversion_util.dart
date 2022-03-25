
import 'package:battle_operation2_app/config/enums.dart';

import 'enum_util.dart';

class NumericConversionUtil {

  /// 数値を受け取り、"勝利"または"敗北"の文字列を返す.
  ///
  /// @param int zeroOrOne: 0は敗北、1は勝利.
  /// @param bool returnEnglish: trueの場合"Win"または"Lose"の文字列を返す.
  static String numToWinOrLose({required int zeroOrOne, bool returnEnglish = false}) {
    if (zeroOrOne == 0) {
      return returnEnglish ? "Lose" : "敗北";
    } else if (zeroOrOne == 1) {
      return returnEnglish ? "Win" : "勝利";
    } else {
      return "不正な値";
    }
  }

  /// 編成のフォーメーションをintで受け取り、強襲汎用支援の数を格納したmapを返す.
  ///
  /// 桁数が1~3でない場合はnullを返す為、呼び出し元でnullチェック必須.
  /// @param formation
  /// @return Map<int, int> デフォルト {1: 0, 2: 0, 3: 0}
  static Map<String, int>? formationConvertToMap(int formation) {
    Map<String, int> _map = {MobileSuitType.Raid.nameEn: 0, MobileSuitType.General.nameEn: 0, MobileSuitType.Support.nameEn: 0};
    int _length = formation.toString().length;
     //最大3桁, 100の位が強襲機の数, 10の位が汎用機の数, 1の位が支援機の数を表す.
    if (_length == 1) {
      _map[MobileSuitType.Support.nameEn] = formation;
    } else if (_length == 2) {
      String _formation = formation.toString();
      String _tensPlace = _formation.substring(0,1);
      String _onesPlace = _formation.substring(1,2);
      _map[MobileSuitType.General.nameEn] = int.parse(_tensPlace);
      _map[MobileSuitType.Support.nameEn] = int.parse(_onesPlace);
    } else if (_length == 3) {
      String _formation = formation.toString();
      String _hundredPlace = _formation.substring(0,1);
      String _tensPlace = _formation.substring(1,2);
      String _onesPlace = _formation.substring(2,3);
      _map[MobileSuitType.Raid.nameEn] = int.parse(_hundredPlace);
      _map[MobileSuitType.General.nameEn] = int.parse(_tensPlace);
      _map[MobileSuitType.Support.nameEn] = int.parse(_onesPlace);
    } else {
      return null;
    }
    return _map;
  }

  static String formationMapConvertToString(Map<int, int> formationMap) {
    String? _text;
    formationMap.forEach((msTypeNum, num) {
      MobileSuitType? _mobileSuitTypeEnum = EnumUtil.getMobileSuitTypeByNum(msTypeNum);
      String? _mobileSuitType = _mobileSuitTypeEnum != null ? EnumUtil.getMobileSuitType(_mobileSuitTypeEnum) : null;
      if (_text == null) {
        _text = _mobileSuitType;
      } else {
        if (_mobileSuitType != null) {
          _text = _text! + "$_mobileSuitType";
        }
      }
    });
    return _text ?? "データがありません";
  }

  /// 数値を受け取り、パーセンテージに変換したStringを返す.
  ///
  /// 小数点以下が全て0の場合は小数点以下を切り捨てる.
  ///
  /// @param num.
  /// @param digits=2 表示する小数点以下の桁数.
  /// @param suffix="%" 数字の末尾に加える文字.
  static String? numConvertToPercentage(dynamic num, {int digits = 2, String suffix = "%"}) {
    if (num.runtimeType == double) {
      double _tmpNum = num * 100;
      String _tmpStrNum = _tmpNum.toStringAsFixed(digits);
      List _tmpList = _tmpStrNum.split(".");
      int _afterDecimalPointNum = int.parse(_tmpList[1]);
      if (_afterDecimalPointNum == 0) {
        return "${_tmpList[0]}" + suffix;
      } else {
        return _tmpStrNum + suffix;
      }
    } else if (num.runtimeType == int) {
      return "$num" + suffix;
    } else {
      return null;
    }
  }
}