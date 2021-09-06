
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
}