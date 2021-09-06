
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';

class BattleRecordAddCard extends StatelessWidget {
  BattleRecordAddCard({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
        child: widget
      ),
    );
  }

}