import 'package:battle_operation2_app/common_widget/drawer_menu.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';

/// アプリ起動時、投票権利の付与の判定を行う.
/// 毎日24時に投票権付与　保有上限なし.
/// 現在の日付と最後に付与された日付を比較し、差分を付与.
class CheckVoteRight {
  late SharedPreferences _prefs;

  /// 投票権付与判定を行い、付与数または0を返す.
  Future<int> isGrantedVoteRight() async {
    _prefs = await SharedPreferences.getInstance();
    DateTime _today = new DateTime.now();
    String _strToday =
        "${_today.year}-${_today.month.toString().padLeft(2, "0")}-${_today.day.toString().padLeft(2, "0")}";

    // 投票権最終付与日を取得 nullでない場合は当日との差を判定し値を返す
    String? _strLastGrantedDay = _prefs.getString(SharedPrefKey.VoteRightGrantDay.toString());
    if (_strLastGrantedDay != null) {
      DateTime _lastGrantedDay = DateTime.parse(_strLastGrantedDay);
      int _diffNum = _today.compareTo(_lastGrantedDay);
      return _diffNum;
    } else {
      // アプリ起動時に予期せぬエラーが発生していた場合のみnullとなる 当日の日付を格納
      _prefs.setString(SharedPrefKey.VoteRightGrantDay.toString(), _strToday);
      return 0;
    }
  }
}
