import 'package:battle_operation2_app/common_widget/battle_record_view/win_rate_pie_chart.dart';
import 'package:battle_operation2_app/common_widget/battle_record_view_bottom_bar.dart';
import 'package:battle_operation2_app/common_widget/custom/custom_container.dart';
import 'package:battle_operation2_app/common_widget/submit_button.dart';
import 'package:battle_operation2_app/config/color_env.dart';
import 'package:battle_operation2_app/controller/view_data_all_controller.dart';
import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
    as myText;
import 'package:battle_operation2_app/repository/battle_record_repository.dart';
import 'package:battle_operation2_app/service/battle_record_view/all_data_view.dart';

/// 総合戦績を表示する.
class ViewDataAll extends StatelessWidget {
  final AllDataViewController allDataViewController =
      Get.find(tag: "allDataView");

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: FutureBuilder(
            future: allDataViewController.getData(),
            builder: (context, AsyncSnapshot<AllDataView?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: myText.Text("データがありません"),
                );
              }
              return Column(
                children: <Widget>[snapshot.data!.allDataViewBody()],
              );
            }),
      ),
    );
  }
}
