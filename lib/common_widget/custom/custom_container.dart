import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// 上部と左右にマージンを設けたContainerウィジェット.
class CustomContainer extends StatelessWidget {
  CustomContainer({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenEnv.deviceWidth * 0.04,
          left: ScreenEnv.deviceWidth * 0.04,
          right: ScreenEnv.deviceWidth * 0.04),
      child: widget,
    );
  }
}
