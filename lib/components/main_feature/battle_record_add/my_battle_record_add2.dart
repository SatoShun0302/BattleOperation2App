import 'package:battle_operation2_app/common_widget/custom/custom_container.dart';
import 'package:battle_operation2_app/common_widget/heading_icon/heading_icon_square.dart';
import 'package:battle_operation2_app/common_widget/headline.dart';
import 'package:battle_operation2_app/config/battle_record_env.dart';
import 'package:battle_operation2_app/controller/my_battle_record_add_controller.dart';
import 'package:battle_operation2_app/helper/numeric_conversion_util.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;
import 'package:search_choices/search_choices.dart';

class MyBattleRecordAdd2 extends StatelessWidget {
  final MyBattleRecordAddController c = Get.find(tag: "myBattleRecordAdd");

  @override
  Widget build(BuildContext context) {
    // 選択済みMsIdを初期化する
    c.choosedMsId1.value = 0;
    c.choosedMsId2.value = 0;
    c.choosedMsId3.value = 0;
    c.choosedMsId4.value = 0;
    c.choosedMsId5.value = 0;
    c.choosedMsId6.value = 0;
    c.choosedMsMap2.value = {};
    c.choosedMsMap3.value = {};

    return Scaffold(
      appBar: AppBar(
        title: Text("出撃前情報入力(2/2)"),
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
                HeadLine(size: HeadLineSize.Medium, text: "自機データ"),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            child: SearchChoices.single(
                              items: c.msDropdownList,
                              value: c.choosedMsId1,
                              hint: myText.Text(
                                "${c.hint}",
                                style: TextStyle(fontSize: 17.0),
                              ),
                              searchHint: c.searchHint,
                              onChanged: (Map<int, String>? value) {
                                c.choosedMsId1.value =
                                    value != null ? value.keys.first : 0;
                              },
                              isExpanded: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.star,color: Colors.yellow,),
                            splashRadius: ScreenEnv.deviceWidth * 0.05,
                            padding: EdgeInsets.all(0),
                            tooltip: c.favoriteHint,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                HeadLine(size: HeadLineSize.Medium, text: "僚機データ (順不同)"),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01),
                                child: SearchChoices.single(
                                  items: c.msDropdownList,
                                  value: c.choosedMsMap2.value,
                                  hint: myText.Text(
                                    "${c.alliesHint}",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  searchHint: c.searchHint,
                                  onChanged: (Map<int, String>? value) {
                                    c.choosedMsId2.value =
                                        value != null ? value.keys.first : 0;
                                    c.choosedMsMap2.value =value!;
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.move_to_inbox_sharp, color: Colors.blueAccent),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.copyHint,
                                onPressed: () {
                                  c.choosedMsMap3.value = c.choosedMsMap2.value;
                                  c.choosedMsId3.value = c.choosedMsId2.value;
                                },
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.star, color: Colors.yellow),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.favoriteHint,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01),
                                child: Obx(() => SearchChoices.single(
                                  items: c.msDropdownList,
                                  value: c.choosedMsMap3.value,
                                  hint: myText.Text(
                                    "${c.alliesHint}",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  searchHint: c.searchHint,
                                  onChanged: (Map<int, String>? value) {
                                    c.choosedMsId3.value =
                                        value != null ? value.keys.first : 0;
                                  },
                                  isExpanded: true,
                                ),),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.move_to_inbox_sharp, color: Colors.blueAccent),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.copyHint,
                                onPressed: () {
                                  if (c.choosedMsId4.value == 0) {c.choosedMsId4.value = c.choosedMsId3.value;}
                                },
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.star, color: Colors.yellow),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.favoriteHint,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01),
                                child: SearchChoices.single(
                                  items: c.msDropdownList,
                                  value: c.choosedMsId4,
                                  hint: myText.Text(
                                    "${c.alliesHint}",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  searchHint: c.searchHint,
                                  onChanged: (Map<int, String>? value) {
                                    c.choosedMsId4.value =
                                        value != null ? value.keys.first : 0;
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.move_to_inbox_sharp, color: Colors.blueAccent),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.copyHint,
                                onPressed: () {
                                  if (c.choosedMsId5.value == 0) {c.choosedMsId5.value = c.choosedMsId4.value;}
                                },
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.star, color: Colors.yellow),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.favoriteHint,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenEnv.deviceWidth * 0.01),
                                child: SearchChoices.single(
                                  items: c.msDropdownList,
                                  value: c.choosedMsId5,
                                  hint: myText.Text(
                                    "${c.alliesHint}",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  searchHint: c.searchHint,
                                  onChanged: (Map<int, String>? value) {
                                    c.choosedMsId5.value =
                                        value != null ? value.keys.first : 0;
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.move_to_inbox_sharp, color: Colors.blueAccent),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.copyHint,
                                onPressed: () {
                                  if (c.choosedMsId6.value == 0) {c.choosedMsId6.value = c.choosedMsId5.value;}
                                },
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.star, color: Colors.yellow),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.favoriteHint,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: SearchChoices.single(
                                  items: c.msDropdownList,
                                  value: c.choosedMsId6,
                                  hint: myText.Text(
                                    "${c.alliesHint}",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  searchHint: c.searchHint,
                                  onChanged: (Map<int, String>? value) {
                                    c.choosedMsId6.value =
                                        value != null ? value.keys.first : 0;
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.move_to_inbox_sharp, color: Colors.blueAccent),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.copyHint,
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.star, color: Colors.yellow),
                                splashRadius: ScreenEnv.deviceWidth * 0.05,
                                padding: EdgeInsets.all(0),
                                tooltip: c.favoriteHint,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                HeadLine(size: HeadLineSize.Medium, text: "その他情報"),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenEnv.deviceWidth * 0.02),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              HeadLine(
                                  size: HeadLineSize.Small,
                                  text: "チーム振り分け",
                                  showUnderLine: true),
                              Obx(
                                () => Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: Text(
                                            "${BattleRecordEnv.teamSideA}側"),
                                        value: BattleRecordEnv.teamSideA,
                                        groupValue: c.choosedSide.value,
                                        onChanged: (String? value) {
                                          c.choosedSide.value = value ??= "";
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: Text(
                                            "${BattleRecordEnv.teamSideB}側"),
                                        value: BattleRecordEnv.teamSideB,
                                        groupValue: c.choosedSide.value,
                                        onChanged: (String? value) {
                                          c.choosedSide.value = value ??= "";
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              HeadLine(
                                  size: HeadLineSize.Small,
                                  text: "勝敗予想",
                                  showUnderLine: true),
                              Obx(
                                () => Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<int>(
                                        title: Text("勝利"),
                                        value: 1,
                                        groupValue: c.choosedPrediction.value,
                                        onChanged: (int? value) {
                                          c.choosedPrediction.value =
                                              value ??= -1;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<int>(
                                        title: Text("敗北"),
                                        value: 0,
                                        groupValue: c.choosedPrediction.value,
                                        onChanged: (int? value) {
                                          c.choosedPrediction.value =
                                              value ??= -1;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
