import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:flutter/cupertino.dart';

enum IconSize { Small, Middle, Large }

/// 見出し用アイコン 四角
class HeadingIconSquare {
  /// 色を3色自由に指定したヘッダーアイコン
  static Widget HeadingIconSquareCustom3() {
    return Stack(
      children: <Widget>[
        // 背面
        Container(
          color: Colors.indigoAccent,
          height: ScreenEnv.deviceWidth * 0.1,
          width: ScreenEnv.deviceWidth * 0.1,
        ),
        // 真ん中
        Container(
          color: Colors.blue,
          height: 250.0,
          width: 250.0,
        ),
        // 前面
        Container(
          color: Colors.lightBlueAccent,
          height: 200.0,
          width: 200.0,
        ),
      ],
    );
  }

  /// 青系2色を使用したヘッダーアイコン
  static Widget HeadingIconSquareBlue2({IconSize size = IconSize.Middle}) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[

        // 真ん中
        Container(
          color: Colors.blue,
          height: ScreenEnv.deviceWidth * 0.05,
          width: ScreenEnv.deviceWidth * 0.05,
        ),
        // 前面
        Container(
          color: Colors.lightBlueAccent,
          height: ScreenEnv.deviceWidth * 0.025,
          width: ScreenEnv.deviceWidth * 0.025,
        ),
      ],
    );
  }

  /// 赤系3色を使用したヘッダーアイコン
  static Widget HeadingIconSquareRed2({IconSize size = IconSize.Middle}) {
    return Stack();
  }

  /// 緑系3色を使用したヘッダーアイコン
  static Widget HeadingIconSquareGreen2({IconSize size = IconSize.Middle}) {
    return Stack();
  }

  /// 青系3色を使用したヘッダーアイコン
  static Widget HeadingIconSquareBlue({IconSize size = IconSize.Middle}) {
    return Stack();
  }

  /// 赤系3色を使用したヘッダーアイコン
  static Widget HeadingIconSquareRed({IconSize size = IconSize.Middle}) {
    return Stack();
  }

  /// 緑系3色を使用したヘッダーアイコン
  static Widget HeadingIconSquareGreen({IconSize size = IconSize.Middle}) {
    return Stack();
  }
}
