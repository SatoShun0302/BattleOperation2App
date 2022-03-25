
import 'dart:ffi';

class CalculationUtil {

  /// (nullable)数値を除法し結果を返す,0で割るなどして結果がNaNまたはInfinityとなった場合はnullを返す.
  ///
  /// @param dividend 割られる数.
  /// @param divisor 割る数.
  /// @param remainder=true 小数点以下を表示するか否かのフラグ.
  /// @param digits=4 小数点以下を表示する場合の桁数 (ex.digits=2の場合,0.5214)
  /// @return double または int または null
  static dynamic division (int dividend, int divisor, {bool remainder = true}) {
    if (remainder) {
      dynamic _result = (dividend / divisor);
      if(_result.isNaN || _result.isInfinite) {
        return null;
      } else if (_result.runtimeType == double) {
        return _result;
      }
    } else {
      dynamic _result = (dividend ~/ divisor);
      if(_result.isNaN || _result.isInfinite) {
        return null;
      } else if (_result.runtimeType == int) {
        return _result;
      }
    }
  }
}