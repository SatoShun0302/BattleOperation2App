
import 'package:battle_operation2_app/components/main_feature/battle_record_view/view_data_all.dart';
import 'package:battle_operation2_app/components/main_feature/battle_record_view/view_data_focus_on_cost.dart';
import 'package:battle_operation2_app/config/screen_env.dart';
import 'package:battle_operation2_app/controller/my_battle_record_add_controller.dart';
import 'package:battle_operation2_app/controller/view_data_all_controller.dart';
import 'package:battle_operation2_app/controller/parts/battle_record_view_bottom_controller.dart';
import 'package:battle_operation2_app/helper/calculation_util.dart';
import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/helper/numeric_conversion_util.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/repository/battle_record_repository.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BattleRecordViewBottomBar extends StatelessWidget {
  final MyBattleRecordAddController c = Get.find(tag: "myBattleRecordAdd");
  final BattleRecordViewBottomController battleRecordViewBottomController =
  Get.find(tag: "battleRecordViewBottomNavigation");
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.react,
      height: ScreenEnv.deviceWidth * 0.16,
      backgroundColor: Colors.teal,
      items: [
        TabItem(icon: Icons.analytics_outlined, title: "総合"),
        TabItem(icon: FaIcon(FontAwesomeIcons.globeAsia, color: Colors.white,), title: "マップ別"),
        TabItem(icon: Icons.analytics_outlined, title: "コスト別"),
        TabItem(icon: FaIcon(FontAwesomeIcons.splotch, color: Colors.white,), title: "機体別"),
      ],
      initialActiveIndex: battleRecordViewBottomController.tabIndex.value,
      onTap: (int i) {
        battleRecordViewBottomController.tabIndex.value = i;
        switch(i) {
          case 0:
            print("index0");

            break;
          case 1:
            print("index1");

            break;
          case 2:
            print("index2");
            print(GetPlatform.isAndroid);
            break;
          case 3:
            BattleRecordRepository battleRecordRepository = new BattleRecordRepository();
            battleRecordRepository.initInsertTestRecords();
            break;
        }
      },
    );
  }

}