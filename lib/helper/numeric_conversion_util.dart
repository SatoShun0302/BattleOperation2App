
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
  static Map<int, int>? formationConvertToMap(int formation) {
    Map<int, int> _map = {1: 0, 2:0, 3:0};
    int _length = formation.toString().length;
     //最大3桁, 100の位が強襲機の数, 10の位が汎用機の数, 1の位が支援機の数を表す.
    if (_length == 1) {
      _map[3] = formation;
    } else if (_length == 2) {
      String _formation = formation.toString();
      String _tensPlace = _formation.substring(0,1);
      String _onesPlace = _formation.substring(1,2);
      _map[2] = int.parse(_tensPlace);
      _map[3] = int.parse(_onesPlace);
    } else if (_length == 3) {
      String _formation = formation.toString();
      String _hundredPlace = _formation.substring(0,1);
      String _tensPlace = _formation.substring(1,2);
      String _onesPlace = _formation.substring(2,3);
      _map[1] = int.parse(_hundredPlace);
      _map[2] = int.parse(_tensPlace);
      _map[3] = int.parse(_onesPlace);
    } else {
      return null;
    }
    return _map;
  }
}