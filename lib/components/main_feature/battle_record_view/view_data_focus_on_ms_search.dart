import 'package:battle_operation2_app/controller/common/mobile_suit_controller.dart';
import 'package:battle_operation2_app/controller/view_data_focus_on_ms_controller.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;
import 'package:search_choices/search_choices.dart';

class ViewDataFocusOnMsSearch extends StatelessWidget {
  ViewDataFocusOnMsSearch({Key? key}) : super(key: key);
  final MobileSuitController mobileSuitController = Get.find(tag: "mobileSuit");
  final ViewDataFocusOnMsController viewDataFocusOnMsController = Get.find(tag: "msDataView");

  @override
  Widget build(BuildContext context) {
    return SearchChoices.single(
      items: viewDataFocusOnMsController.msDropdownList,
      value: viewDataFocusOnMsController.chosenMsMap.value,
      hint: myText.Text(
        "Search",
        style: TextStyle(fontSize: 17.0),
      ),
      searchHint: viewDataFocusOnMsController.searchHint,
      onChanged: (Map<int, String>? value) {
        viewDataFocusOnMsController.chosenMsId.value =
        value != null ? value.keys.first : 0;
        viewDataFocusOnMsController.chosenMsMap.value = value!;
      },
      isExpanded: true,
    );
  }
}
