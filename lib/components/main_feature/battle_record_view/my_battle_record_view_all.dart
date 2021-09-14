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
          var now = new DateTime.now();
          print(now);
          print(now.timeZoneName);
          print(DateTimeUtil.weekdayNumConvertToString(now.weekday));
          print(DateTimeUtil.dateTimeConvertToUnixTime(now));
          print(DateTimeUtil.unixTimeConvertToDateTime(DateTimeUtil.dateTimeConvertToUnixTime(now)));
          print(DateTimeUtil.dateTimeConvertToString(now));
          switch(i) {
            case 0:
              print("index0");
              break;
            case 1:
              print("index1");
              BattleRecordRepository battleRecordRepository = new BattleRecordRepository();
              battleRecordRepository.initInsertTestRecords();
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
