import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// 上部と左右にマージンを設けたContainerウィジェット.
class CustomContainer extends StatelessWidget {
  CustomContainer(
      {Key? key,
      required this.widget,
      this.topMargin,
      this.leftMargin,
      this.rightMargin,
      this.bottomMargin})
      : super(key: key);
  /// コンテナのchild
  final Widget widget;
  /// トップマージン,デフォルト=ScreenEnv.deviceWidth * 0.04
  final double? topMargin;
  /// レフトマージン,デフォルト=ScreenEnv.deviceWidth * 0.04
  final double? leftMargin;
  /// ライトマージン,デフォルト=ScreenEnv.deviceWidth * 0.04
  final double? rightMargin;
  /// ボトムマージン,デフォルト=0
  final double? bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: this.topMargin != null
              ? this.topMargin!
              : ScreenEnv.deviceWidth * 0.04,
          left: this.leftMargin != null
              ? this.leftMargin!
              : ScreenEnv.deviceWidth * 0.04,
          right: this.rightMargin != null
              ? this.rightMargin!
              : ScreenEnv.deviceWidth * 0.04,
          bottom: this.bottomMargin != null
              ? this.bottomMargin!
              : 0),
      child: widget,
    );
  }
}
