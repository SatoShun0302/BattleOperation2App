import 'dart:collection';

import 'package:battle_operation2_app/common_widget/battle_record_view/formation_text_line.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/helper/numeric_conversion_util.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

class TopThreeDataTextArea extends StatelessWidget {
  const TopThreeDataTextArea(
      {Key? key,
      required List<Map<String, dynamic>> this.winRateFormationPerCost})
      : super(key: key);

  final winRateFormationPerCost;

  @override
  Widget build(BuildContext context) {
    int _itemCount = winRateFormationPerCost.length;

    return SizedBox(
      height: ScreenEnv.deviceWidth * 0.6,
      child: PageView.builder(
          itemCount: _itemCount,
          controller: PageController(viewportFraction: 1.0),
          itemBuilder: (BuildContext context, int itemIndex) {
            return Card(
                elevation: 5,
                color: Colors.white10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      _buildColumnChildren(itemIndex, winRateFormationPerCost),
                ));
          }),
    );
  }

  List<Widget> _buildColumnChildren(
      int itemIndex, List<Map<String, dynamic>> winRateFormationPerCost) {
    List<Widget> _widgetList = [];
    winRateFormationPerCost
        .asMap()
        .forEach((index, Map<String, dynamic> mapPerCost) {
      if (itemIndex == index) {
        // columnのchildrenに指定するwidget
        int cost = mapPerCost["cost"];
        Map<int, double> winRatePerFormation = mapPerCost["winRate"];
        // 勝率が高い順に並び変える
        winRatePerFormation = SplayTreeMap.from(
            winRatePerFormation,
            (a, b) =>
                winRatePerFormation[b]!.compareTo(winRatePerFormation[a]!));
        int _winRateMapCounter = 1;
        // コストに紐づくデータMapが存在している場合とそうでない場合で返すWidget Listを分岐する
        if (winRatePerFormation.isNotEmpty) {
          if (_winRateMapCounter <= 3) {
            winRatePerFormation.forEach((formation, winRate) {
              print(NumericConversionUtil.formationConvertToMap(formation));
              Widget _widget = Padding(
                padding: EdgeInsets.only(left: ScreenEnv.deviceWidth * 0.05),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: FormationTextLine(formation: NumericConversionUtil.formationConvertToMap(formation)!)),
                    Expanded(
                        flex: 1,
                        child: myText.Text("${(winRate * 100).floor()}%",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenEnv.deviceWidth * 0.04)))
                  ],
                ),
              );
              _widgetList.add(_widget);
              _winRateMapCounter++;
            });
          }
          // データが1件以上は存在するが3件に満たない場合は3件になるよう調整する
          int _listLength = _widgetList.length;
          for (int i = _listLength; i < 3; i++) {
            Widget _widget = Padding(
                padding: const EdgeInsets.all(20.0),
                child: myText.Text("${i + 1}位のデータが存在しません",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenEnv.deviceWidth * 0.04)));
            _widgetList.add(_widget);
          }
        } else {
          Widget _widget = Padding(
              padding: const EdgeInsets.all(20.0),
              child: myText.Text("データが存在しません",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenEnv.deviceWidth * 0.04)));
          _widgetList.add(_widget);
        }
      }
    });
    return _widgetList;
  }
}
