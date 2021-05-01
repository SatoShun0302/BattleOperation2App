import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/importer/dart_importer.dart';
import 'package:battle_operation2_app/common_widget/custom/my_text.dart'
as myText;
import 'package:battle_operation2_app/repository/map_list_repository.dart';

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myText.Text("テスト画面"),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
MapListRepository mlr = new MapListRepository();
          },
              child: myText.Text("テーブルを作成する")),
        ],
      ),
    );
  }
}
