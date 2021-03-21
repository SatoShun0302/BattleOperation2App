import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// 画面サイズやそれに依存するデザインで使用する定数クラス
class ScreenEnv {

  static double _deviceWidth;
  static double _deviceHeight;
  static set deviceWidth(double width) => _deviceWidth = width;
  static set deviceHeight(double height) => _deviceHeight = height;
  static get deviceWidth => _deviceWidth;
  static get deviceHeight => _deviceHeight;

}