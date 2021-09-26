import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/helper/numeric_conversion_util.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

class NumberOfSortiesAndWinRate extends StatelessWidget {
  const NumberOfSortiesAndWinRate(
      {Key? key,
      required int this.numberOfSortie,
      required double this.winRate,
      required int this.numberOfWin,
      required int this.numberOfLose,
      double? this.teamAWinRate,
      double? this.teamBWinRate})
      : super(key: key);

  final numberOfSortie;
  final numberOfWin;
  final numberOfLose;
  final winRate;
  final teamAWinRate;
  final teamBWinRate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white10,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: myText.Text(
                    "総合出撃回数：",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenEnv.deviceWidth * 0.04),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: myText.Text("$numberOfSortie回",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: myText.Text("勝利回数：",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
                Expanded(
                  flex: 2,
                  child: myText.Text(
                      "$numberOfWin回",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: myText.Text("敗北回数：",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
                Expanded(
                  flex: 2,
                  child: myText.Text(
                      "$numberOfLose回",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: myText.Text("総合勝率：",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
                Expanded(
                  flex: 2,
                  child: myText.Text(
                      "${NumericConversionUtil.numConvertToPercentage(winRate)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
              ],
            ),
          ),
          if (teamAWinRate != null) Padding(
            padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: myText.Text("A側勝率：",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
                Expanded(
                  flex: 2,
                  child: myText.Text(
                      "${NumericConversionUtil.numConvertToPercentage(teamAWinRate)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
              ],
            ),
          ),
          if (teamBWinRate != null) Padding(
            padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: myText.Text("B側勝率：",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
                Expanded(
                  flex: 2,
                  child: myText.Text(
                      "${NumericConversionUtil.numConvertToPercentage(teamBWinRate)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenEnv.deviceWidth * 0.04)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
