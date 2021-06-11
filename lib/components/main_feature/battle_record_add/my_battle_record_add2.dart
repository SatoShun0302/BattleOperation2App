import 'package:battle_operation2_app/common_widget/heading_icon/heading_icon_square.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:ScreenEnv.deviceWidth * 0.05, bottom: ScreenEnv.deviceWidth * 0.05),
              child: Row(
                children: [
                  HeadingIconSquare.HeadingIconSquareBlue2(),
                  myText.Text("自機体データ入力"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:ScreenEnv.deviceWidth * 0.05, bottom: ScreenEnv.deviceWidth * 0.05),
              child: Row(
                children: [
                  HeadingIconSquare.HeadingIconSquareBlue2(),
                  myText.Text("味方機体データ入力"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:ScreenEnv.deviceWidth * 0.05, bottom: ScreenEnv.deviceWidth * 0.05),
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
    );
  }
}
