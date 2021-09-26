import 'package:battle_operation2_app/common_widget/battle_record_view/win_rate_pie_chart.dart';
import 'package:battle_operation2_app/common_widget/battle_record_view_bottom_bar.dart';
import 'package:battle_operation2_app/common_widget/custom/custom_container.dart';
import 'package:battle_operation2_app/common_widget/submit_button.dart';
import 'package:battle_operation2_app/config/color_env.dart';
import 'package:battle_operation2_app/controller/all_data_view_controller.dart';
import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;
import 'package:battle_operation2_app/repository/battle_record_repository.dart';
import 'package:battle_operation2_app/service/battle_record_view/all_ground_data_view5.dart';

/// 総合戦績を表示する, チームメンバー5人用画面
class ViewDataAll extends StatelessWidget {
  final AllDataViewController allDataViewController = Get.find(tag: "allDataView");

  @override
  Widget build(BuildContext context) {
    // 選択されている人数を判別, その後地上と宇宙どちらが選択されているかによって所定のウィジェットを返す.
    switch (allDataViewController.numberOfChosenPlayer.value) {
      case 5:
        return SingleChildScrollView(
          child: FutureBuilder(
              future: allDataViewController.getAllGroundDataView5(),
              builder: (context, AsyncSnapshot<AllGroundDataView5?> snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return Center(
                    child: myText.Text("データがありません"),
                  );
                }
                return Column(
                  children: <Widget>[
                    snapshot.data!.allGroundDataViewBody()
                  ],
                );
              }
          ),
        );
      case 6:
        return SingleChildScrollView(
          child: FutureBuilder(
              future: allDataViewController.getAllGroundDataView5(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError || snapshot == null) {
                  return Center(
                    child: myText.Text("データがありません"),
                  );
                }
                return Column(
                  children: <Widget>[
                    myText.Text("6人　全部")
                  ],
                );
              }
          ),
        );
      default:
        return SingleChildScrollView(
          child: FutureBuilder(
              future: allDataViewController.getAllGroundDataView5(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError || snapshot == null) {
                  return Center(
                    child: myText.Text("データがありません"),
                  );
                }
                return Column(
                  children: <Widget>[
                    myText.Text("デフォルト　全部")
                  ],
                );
              }
          ),
        );
    }
  }
}
