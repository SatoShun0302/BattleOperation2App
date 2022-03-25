import 'package:battle_operation2_app/common_widget/headline.dart';
import 'package:battle_operation2_app/common_widget/submit_button.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/my_battle_record_view.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/view_data_all.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/controller/view_data_all_controller.dart';
import 'package:battle_operation2_app/controller/view_data_focus_on_map_controller.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;

class ViewDataFocusOnMapMenu extends StatelessWidget {
  const ViewDataFocusOnMapMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ViewDataFocusOnMapController viewDataFocusOnMapController =
    Get.find(tag: "mapDataView");
    return IconButton(
        icon: Icon(Icons.build),
        padding: EdgeInsets.only(top: ScreenEnv.deviceWidth * 0.02),
        onPressed: () {
          Get.bottomSheet(
            SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      HeadLine(text: "チーム人数",size: HeadLineSize.Small),
                      Obx(
                            () => Row(
                          children: [
                            Expanded(
                              child: RadioListTile<int>(
                                title: Text("5人"),
                                value: 5,
                                groupValue: viewDataFocusOnMapController
                                    .numberOfChosenPlayer.value,
                                onChanged: (int? value) {
                                  viewDataFocusOnMapController.numberOfChosenPlayer
                                      .value = value ??= -1;
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<int>(
                                title: Text("6人"),
                                value: 6,
                                groupValue: viewDataFocusOnMapController
                                    .numberOfChosenPlayer.value,
                                onChanged: (int? value) {
                                  viewDataFocusOnMapController.numberOfChosenPlayer
                                      .value = value ??= -1;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      HeadLine(text: "マップ",size: HeadLineSize.Small),
                      FutureBuilder(
                        future: viewDataFocusOnMapController.getMapList(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError || viewDataFocusOnMapController.mapDropdownList.isEmpty) {
                            return myText.Text("マップ一覧を取得できませんでした");
                          }
                          return Center(
                            child: Obx(
                                  () => DropdownButton(
                                isExpanded: true,
                                items: viewDataFocusOnMapController.mapDropdownList,
                                value: viewDataFocusOnMapController.chosenMapId.value,
                                onChanged: (int? value) => {
                                  viewDataFocusOnMapController.chosenMapId.value = value!,
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      // SubmitButton(
                      //     child: myText.Text("設定を反映する"), onPressed: () async {
                      //   await allDataViewController.getData();
                      // }),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
          );
        });
  }
}
