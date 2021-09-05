import 'package:battle_operation2_app/common_widget/heading_icon/heading_icon_square.dart';
import 'package:battle_operation2_app/controller/my_battle_record_add_controller.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

import 'my_battle_record_add2.dart';

class MyBattleRecordAdd extends StatelessWidget {
  final MyBattleRecordAddController c = Get.find(tag: "myBattleRecordAdd");

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
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
                ),
                height: ScreenEnv.deviceWidth * 0.13,
                width: ScreenEnv.deviceWidth * 0.8,
                margin: EdgeInsets.only(
                    top: ScreenEnv.deviceWidth * 0.04,
                    bottom: ScreenEnv.deviceWidth * 0.04),
                alignment: Alignment.center,
                child: myText.Text(
                  "出撃準備",
                  style: TextStyle(fontSize: ScreenEnv.deviceWidth * 0.08),
                ),
              ),
            ),
            Row(
              children: [
                HeadingIconSquare.HeadingIconSquareBlue2(),
                myText.Text("マップ"),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: ScreenEnv.deviceWidth * 0.05),
              child: FutureBuilder(
                future: c.getMapList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError || c.mapDropdownList.isEmpty) {
                    return myText.Text("マップ一覧を取得できませんでした");
                  }
                  return Center(
                    child: Obx(
                      () => DropdownButton(
                        items: c.mapDropdownList,
                        value: c.choosedMapId.value,
                        onChanged: (int? value) => {
                          c.choosedMapId.value = value!,
                          print(c.choosedMapId.value),
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                HeadingIconSquare.HeadingIconSquareBlue2(),
                myText.Text("コスト"),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: ScreenEnv.deviceWidth * 0.05),
              child: FutureBuilder(
                  future: c.getCostList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError || c.costDropdownList.isEmpty) {
                      return myText.Text("コスト一覧を取得できませんでした");
                    }
                    return Center(
                      child: Obx(
                        () => DropdownButton(
                          items: c.costDropdownList,
                          value: c.choosedCost.value,
                          onChanged: (int? value) => {
                            c.choosedCost.value = value!,
                            print(c.choosedCost.value),
                          },
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                HeadingIconSquare.HeadingIconSquareBlue2(),
                myText.Text("対戦人数"),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: ScreenEnv.deviceWidth * 0.05),
              child: FutureBuilder(
                  future: c.getNumberOfPlayerList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError || c.numberOfPlayerList == []) {
                      return myText.Text("対戦人数一覧を取得できませんでした");
                    }
                  return Center(
                    child: Obx(
                          () => DropdownButton(
                        items: c.numberOfPlayerList,
                        value: c.choosedNumberOfPlayer.value,
                        onChanged: (int? value) => {
                          c.choosedNumberOfPlayer.value = value!,
                          print(c.choosedNumberOfPlayer.value),
                        },
                      ),
                    ),
                  );
                }
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.off(() => MyBattleRecordAdd2());
              },
              child: myText.Text("次へ"),
            ),
          ],
        ),
      ),
    );
  }
}
