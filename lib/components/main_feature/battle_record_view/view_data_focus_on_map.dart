import 'package:battle_operation2_app/common_widget/custom/custom_container.dart';
import 'package:battle_operation2_app/common_widget/headline.dart';
import 'package:battle_operation2_app/controller/view_data_all_controller.dart';
import 'package:battle_operation2_app/controller/view_data_focus_on_map_controller.dart';
import 'package:battle_operation2_app/helper/datetime_util.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;
import 'package:battle_operation2_app/repository/battle_record_repository.dart';
import 'package:battle_operation2_app/service/battle_record_view/all_data_view.dart';
import 'package:battle_operation2_app/service/battle_record_view/focus_on_map_view.dart';

class ViewDataFocusOnMap extends StatelessWidget {
  const ViewDataFocusOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ViewDataFocusOnMapController viewDataFocusOnMapController = Get.find(tag: "mapDataView");
    return Obx(
          () => SingleChildScrollView(
        child: FutureBuilder(
            future: viewDataFocusOnMapController.getData(),
            builder: (context, AsyncSnapshot<FocusOnMapView?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: myText.Text("データがありません"),
                );
              }
              return CustomContainer(
                leftMargin: ScreenEnv.deviceWidth * 0.02,
                rightMargin: ScreenEnv.deviceWidth * 0.02,
                widget: Column(
                  children: <Widget>[
                    HeadLine(text: '■ 基本情報', textColor: Colors.lightGreen),
                    snapshot.data!.topInformation(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
