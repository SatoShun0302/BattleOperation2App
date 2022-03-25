import 'package:battle_operation2_app/common_widget/headline.dart';
import 'package:battle_operation2_app/common_widget/submit_button.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/my_battle_record_view.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/view_data_all.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/controller/view_data_all_controller.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

class ViewDataAllMenu extends StatelessWidget {
  const ViewDataAllMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllDataViewController allDataViewController =
        Get.find(tag: "allDataView");

    return IconButton(
        icon: Icon(Icons.add),
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
                                groupValue: allDataViewController
                                    .numberOfChosenPlayer.value,
                                onChanged: (int? value) {
                                  allDataViewController.numberOfChosenPlayer
                                      .value = value ??= -1;
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<int>(
                                title: Text("6人"),
                                value: 6,
                                groupValue: allDataViewController
                                    .numberOfChosenPlayer.value,
                                onChanged: (int? value) {
                                  allDataViewController.numberOfChosenPlayer
                                      .value = value ??= -1;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      HeadLine(text: "マップ",size: HeadLineSize.Small),
                      Obx(
                            () => Row(
                          children: [
                            Expanded(
                              child: RadioListTile<bool>(
                                title: Text("地上"),
                                value: true,
                                groupValue: allDataViewController
                                    .isChosenGround.value,
                                onChanged: (bool? value) {
                                  allDataViewController.isChosenGround
                                      .value = value!;
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<bool>(
                                title: Text("宇宙"),
                                value: false,
                                groupValue: allDataViewController
                                    .isChosenGround.value,
                                onChanged: (bool? value) {
                                  allDataViewController.isChosenGround
                                      .value = value!;
                                },
                              ),
                            ),
                          ],
                        ),
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
