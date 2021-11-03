import 'package:battle_operation2_app/config/color_env.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

class BattleRecordDivider extends StatelessWidget {
  const BattleRecordDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorEnv.appBarBackground,
      thickness: ScreenEnv.deviceWidth * 0.005,
      height: ScreenEnv.deviceWidth * 0.1,
    );
  }
}
