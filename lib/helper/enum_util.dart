import 'package:battle_operation2_app/importer/myclass_importer.dart';

/// Enumの値を参照し、文字列や数値、条件といった値を返すメソッドを記述するクラス
class EnumUtil {

  /// MSタイプを返す
  ///
  /// @param MobileSuitType @return String
  static String getMobileSuitType(MobileSuitType msType) {
    switch (msType) {
      case MobileSuitType.General:
        return "汎用";
      case MobileSuitType.Support:
        return "支援";
      case MobileSuitType.Raid:
        return "強襲";
    }
  }

  /// 数値をもとにenum MobileSuitTypeを返す.
  ///
  /// @param num 1~3の数字.
  /// @return enum MobileSuitType または null.
  static MobileSuitType? getMobileSuitTypeByNum(int num) {
    switch (num) {
      case 1:
        return MobileSuitType.Raid;
      case 2:
        return MobileSuitType.General;
      case 3:
        return MobileSuitType.Support;
      default:
        return null;
    }
  }

  /// フィールドタイプを返す
  ///
  /// @param FieldType @return String
  static String fieldType(FieldType field) {
    switch (field) {
      case FieldType.Ground:
        return "地上";
      case FieldType.Space:
        return "宇宙";
    }
  }
}
