import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

/// 登録、次の画面へ遷移など正常系処理に使用するボタン
class SubmitButton extends StatelessWidget {
  SubmitButton({
    Key? key,
    required Widget this.child,
    required Function this.onPressed,
    double this.topPadding = 20,
    double this.bottomPadding = 10,
    double this.leftPadding = 0,
    double this.rightPadding = 0,

}) : super(key: key);
  final child;
  final onPressed;
  final topPadding;
  final bottomPadding;
  final leftPadding;
  final rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding, left: leftPadding, right: rightPadding),
      child: ElevatedButton(
          child: child,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(80)),
            ),
            elevation: 4.0,
            fixedSize: Size.fromWidth(ScreenEnv.deviceWidth * 0.6),
          ),
          onPressed: onPressed,
      ),
    );
  }

}