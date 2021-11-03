import 'package:battle_operation2_app/common_widget/battle_record_view_bottom_bar.dart';
import 'package:battle_operation2_app/common_widget/submit_button.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/view_data_all_menu.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/view_data_focus_on_cost.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/view_data_focus_on_map.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/view_data_focus_on_map_menu.dart';
import 'package:battle_operation2_app/config/color_env.dart';
import 'package:battle_operation2_app/controller/parts/battle_record_view_bottom_controller.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;

class MyBattleRecordView extends StatelessWidget {
  final BattleRecordViewBottomController battleRecordViewBottomController =
      Get.find(tag: "battleRecordViewBottomNavigation");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorEnv.scaffoldBackground,
      appBar: AppBar(
        title: myText.Text(""),
        backgroundColor: ColorEnv.appBarBackground,
        actions: <Widget>[
          Obx(
            () => IndexedStack(
              index: battleRecordViewBottomController.tabIndex.value,
              children: <Widget>[
                ViewDataAllMenu(),
                ViewDataFocusOnMapMenu(),
              ],
            ),
          ),
        ],
      ),
      // ドロワーメニュー
      drawer: SafeArea(
        child: Drawer(
          child: new DrawerMenu().expansionPanelList(),
        ),
      ),
      // ボトムメニュー
      bottomNavigationBar: BattleRecordViewBottomBar(),
      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: battleRecordViewBottomController.tabIndex.value,
            children: <Widget>[
              ViewDataAll(),
              ViewDataFocusOnMap(),
            ],
          ),
        ),
      ),
    );
  }
}
