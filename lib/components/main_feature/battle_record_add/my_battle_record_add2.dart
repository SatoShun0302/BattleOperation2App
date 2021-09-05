import 'package:battle_operation2_app/common_widget/custom/custom_container.dart';
import 'package:battle_operation2_app/common_widget/heading_icon/heading_icon_square.dart';
import 'package:battle_operation2_app/common_widget/headline.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

class MyBattleRecordAdd2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.orange,
      ),
      drawer: SafeArea(
        child: Drawer(
          child: new DrawerMenu().expansionPanelList(),
        ),
      ),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Scrollbar(
        child: SingleChildScrollView(
          child: CustomContainer(
            widget: Column(
              children: <Widget>[
                HeadLine(
                    size: HeadLineSize.Medium, text: "自機データ"),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
                    child: Row(
                      children: [
                        Container(
                              child: myText.Text("051 , intVer: ${int.parse("051")}"),
                        ),
                      ],
                    ),
                  ),
                ),
                HeadLine(
                    size: HeadLineSize.Medium, text: "僚機データ"),
                HeadLine(
                    size: HeadLineSize.Medium, text: "その他情報"),
                HeadLine(
                    size: HeadLineSize.Small, text: "チーム振り分け", showUnderLine: true),
                HeadLine(
                    size: HeadLineSize.Small, text: "勝敗予想", showUnderLine: true),
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenEnv.deviceWidth * 0.05,
                      bottom: ScreenEnv.deviceWidth * 0.05),
                  child: Row(
                    children: [
                      HeadingIconSquare.HeadingIconSquareBlue2(),
                      myText.Text("自機体データ入力"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenEnv.deviceWidth * 0.05,
                      bottom: ScreenEnv.deviceWidth * 0.05),
                  child: Row(
                    children: [
                      HeadingIconSquare.HeadingIconSquareBlue2(),
                      myText.Text("味方機体データ入力"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenEnv.deviceWidth * 0.05,
                      bottom: ScreenEnv.deviceWidth * 0.05),
                  child: Row(
                    children: [
                      HeadingIconSquare.HeadingIconSquareBlue2(),
                      myText.Text("その他情報入力"),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("test");
                  },
                  child: myText.Text("出撃"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
