import 'package:battle_operation2_app/common_widget/battle_record_view_bottom_bar.dart';
import 'package:battle_operation2_app/config/color_env.dart';
import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;
import 'package:battle_operation2_app/repository/battle_record_repository.dart';

class MyBattleRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorEnv.scaffoldBackground,
      appBar: AppBar(
        title: myText.Text(""),
        backgroundColor: ColorEnv.appBarBackground,
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
