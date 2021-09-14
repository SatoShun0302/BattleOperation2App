
import 'package:intl/intl.dart';

/// 日付操作用メソッドを定義した汎用クラス
class DateTimeUtil {
  static const String monday = "月";
  static const String tuesday = "火";
  static const String wednesday = "水";
  static const String thursday = "木";
  static const String friday = "金";
  static const String saturday = "土";
  static const String sunday = "日";
  static const int mondayNum = 1;
  static const int tuesdayNum = 2;
  static const int wednesdayNum = 3;
  static const int thursdayNum = 4;
  static const int fridayNum = 5;
  static const int saturdayNum = 6;
  static const int sundayNum = 7;
  static const String suffix = "曜日";

  /// 数値で受け取った曜日を文字列で返す.
  ///
  /// @param isAbbreviate = true: "曜日"という文字列を省略するか否か,デフォルトは省略.
  /// @return 曜日
  static String weekdayNumConvertToString(int weekday, {bool isAbbreviate = true}) {
    String _strWeekday = "";
    switch (weekday) {
      case mondayNum:
        _strWeekday = monday;
        break;
      case tuesdayNum:
        _strWeekday = tuesday;
        break;
      case wednesdayNum:
        _strWeekday = wednesday;
        break;
      case thursdayNum:
        _strWeekday = thursday;
        break;
      case fridayNum:
        _strWeekday = friday;
        break;
      case saturdayNum:
        _strWeekday = saturday;
        break;
      case sundayNum:
        _strWeekday = sunday;
        break;
      default:
        _strWeekday = "取得エラー";
        break;
    }
    if (!isAbbreviate) {
      _strWeekday = _strWeekday + suffix;
    }
    return _strWeekday;
  }

  /// DateTime型の日付をunixTimeに変換して返す.
  ///
  /// @param dateTime.
  /// @return unixTime.
  static int dateTimeConvertToUnixTime(DateTime dateTime) {
    return dateTime.toUtc().millisecondsSinceEpoch;
  }

  /// unixTimeの日付をDateTime型に変換して返す.
  ///
  /// @param unixTime.
  /// @return DateTime.
  static DateTime unixTimeConvertToDateTime(int unixTime) {
    return  new DateTime.fromMillisecondsSinceEpoch(unixTime);
  }

  /// dateTime型の日付を指定されたformat形式の文字列に変換して返す.
  static String dateTimeConvertToString(DateTime dateTime, {String format = "yyyy年MM月dd日 HH時mm分ss秒"}) {
    return new DateFormat(format).format(dateTime).toString();
  }
}