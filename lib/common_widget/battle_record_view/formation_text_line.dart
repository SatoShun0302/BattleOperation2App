import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/helper/numeric_conversion_util.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

class FormationTextLine extends StatelessWidget {
  const FormationTextLine({Key? key, required this.formation})
      : super(key: key);

  final Map<String, int> formation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildRowChildren(),
    );
  }

  List<Widget> _buildRowChildren() {
    List<Widget> _widgetList = [];
    int _raidNum = formation[MobileSuitType.Raid.nameEn]!;
    int _generalNum = formation[MobileSuitType.General.nameEn]!;
    int _supportNum = formation[MobileSuitType.Support.nameEn]!;
    _widgetList.add(_mobileSuitSquare(MobileSuitType.Raid, _raidNum));
    _widgetList.add(_mobileSuitSquare(MobileSuitType.General, _generalNum));
    _widgetList.add(_mobileSuitSquare(MobileSuitType.Support, _supportNum));
    return _widgetList;
  }

  Widget _mobileSuitSquare(MobileSuitType msType, int numOfPlayer) {
    Widget _widget = Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: ScreenEnv.deviceWidth * 0.1,
          width: ScreenEnv.deviceWidth * 0.1,
          decoration: BoxDecoration(
            color: msType.msTypeColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: myText.Text(msType.nameJaShortened,
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenEnv.deviceWidth * 0.04, fontWeight: FontWeight.bold)),
        ),
        Container(
          alignment: Alignment.center,
          height: ScreenEnv.deviceWidth * 0.1,
          width: ScreenEnv.deviceWidth * 0.1,
          child: myText.Text("$numOfPlayer",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenEnv.deviceWidth * 0.04)),
        ),
      ],
    );
    return _widget;
  }
}
