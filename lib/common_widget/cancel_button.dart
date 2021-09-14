
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

class CancelButton extends StatelessWidget {
  CancelButton({
    Key? key,
    required Widget this.child,
    required Function this.onPressed,
    double this.topPadding = 10,
    double this.bottomPadding = 20,
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
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(127, 127, 127, 1),
          onPrimary: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(80)),
          ),
          elevation: 4.0,
          fixedSize: Size.fromWidth(ScreenEnv.deviceWidth * 0.3),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }

}