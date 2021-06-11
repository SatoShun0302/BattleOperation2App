import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;

class MyBattleRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myText.Text(""),
        backgroundColor: Colors.orange,
      ),
      // ドロワーメニュー
      drawer: SafeArea(
        child: Drawer(
          child: new DrawerMenu().expansionPanelList(),
        ),
      ),
      // ボトムメニュー
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        height: ScreenEnv.deviceHeight * 0.08,
        items: [
          TabItem(icon: FaIcon(FontAwesomeIcons.globeAsia, color: Colors.white,), title: "地上戦績"),
          TabItem(icon: Icons.analytics_outlined, title: "総合"),
          TabItem(icon: FaIcon(FontAwesomeIcons.splotch, color: Colors.white,), title: "宇宙戦績"),
        ],
        initialActiveIndex: 1,
        onTap: (int i) {
          print(i);
          switch(i) {
            case 0:
              print("index0");
              break;
            case 1:
              print("index1");
              break;
            case 2:
              print("index2");
              break;
          }
        },
      ),
      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("test")
          ],
        ),
      ),
    );
  }
}
