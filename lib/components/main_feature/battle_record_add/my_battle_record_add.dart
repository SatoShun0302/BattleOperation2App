import 'package:battle_operation2_app/common_widget/cancel_button.dart';
import 'package:battle_operation2_app/common_widget/custom/battle_record_add_card.dart';
import 'package:battle_operation2_app/common_widget/custom/custom_container.dart';
import 'package:battle_operation2_app/common_widget/heading_icon/heading_icon_square.dart';
import 'package:battle_operation2_app/common_widget/headline.dart';
import 'package:battle_operation2_app/common_widget/submit_button.dart';
import 'package:battle_operation2_app/config/color_env.dart';
import 'package:battle_operation2_app/controller/my_battle_record_add_controller.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;
import 'package:search_choices/search_choices.dart';

import 'my_battle_record_add2.dart';

class MyBattleRecordAdd extends StatelessWidget {
  final MyBattleRecordAddController c = Get.find(tag: "myBattleRecordAdd");
  @override
  Widget build(BuildContext context) {
    c.init();
    return Scaffold(
      backgroundColor: ColorEnv.scaffoldBackground,
      appBar: AppBar(
        title: Text("出撃前情報入力(1/2)"),
        backgroundColor: ColorEnv.appBarBackground,
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
                    size: HeadLineSize.Medium,
                    text: "マップ",
                    textColor: Colors.white),
                BattleRecordAddCard(
                  widget: Container(
                    child: FutureBuilder(
                      future: c.getMapList(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError || c.mapDropdownList.isEmpty) {
                          return myText.Text("マップ一覧を取得できませんでした");
                        }
                        return Center(
                          child: Obx(
                            () => DropdownButton(
                              isExpanded: true,
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
                ),
                HeadLine(
                    size: HeadLineSize.Medium,
                    text: "コスト",
                    textColor: Colors.white),
                BattleRecordAddCard(
                  widget: Container(
                    child: FutureBuilder(
                        future: c.getCostList(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError || c.costDropdownList.isEmpty) {
                            return myText.Text("コスト一覧を取得できませんでした");
                          }
                          return Center(
                            child: Obx(
                              () => DropdownButton(
                                isExpanded: true,
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
                ),
                HeadLine(
                    size: HeadLineSize.Medium,
                    text: "対戦人数",
                    textColor: Colors.white),
                BattleRecordAddCard(
                  widget: Container(
                    child: FutureBuilder(
                        future: c.getNumberOfPlayerList(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError || c.numberOfPlayerList == []) {
                            return myText.Text("対戦人数一覧を取得できませんでした");
                          }
                          return Center(
                            child: Obx(
                              () => DropdownButton(
                                isExpanded: true,
                                items: c.numberOfPlayerList,
                                value: c.choosedNumberOfPlayer.value,
                                onChanged: (int? value) => {
                                  c.choosedNumberOfPlayer.value = value!,
                                  print(c.choosedNumberOfPlayer.value),
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SubmitButton(
                  onPressed: () async {
                    await c.getMsList();
                    Get.off(() => MyBattleRecordAdd2());
                  },
                  child: myText.Text(
                    "次へ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                CancelButton(
                  onPressed: () {
                    Get.off(() => MainScreen());
                  },
                  child: myText.Text(
                    "前画面に戻る",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
