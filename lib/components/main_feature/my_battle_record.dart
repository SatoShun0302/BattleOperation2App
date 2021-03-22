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
        title: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
          ),

          child: Row(
            children: <Widget>[
              GestureDetector(
                child: myText.Text("地上戦績表示"),
                onTap: () {
                  print("ground");
                },
              ),
              GestureDetector(
                child: myText.Text("宇宙戦績表示"),
                onTap: () {
                  print("space");
                },
              ),
            ],
          ),
        ),
        actions: [
        ],
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
            Text("test")
          ],
        ),
      ),
    );
  }
}
