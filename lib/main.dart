import 'package:battle_operation2_app/common_widget/drawer_menu.dart';
import 'package:battle_operation2_app/controller/view_data_all_controller.dart';
import 'package:battle_operation2_app/controller/parts/battle_record_view_bottom_controller.dart';
import 'package:battle_operation2_app/controller/view_data_focus_on_map_controller.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:battle_operation2_app/repository/map_list_repository.dart';
import 'package:battle_operation2_app/repository/ms_list_repository.dart';
import 'package:battle_operation2_app/service/init_function/check_vote_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/common/mobile_suit_controller.dart';
import 'controller/my_battle_record_add_controller.dart';
import 'controller/view_data_focus_on_ms_controller.dart';
import 'repository/ms_type_list_repository.dart';

Future<void> main() async {
  // main関数内で非同期処理を行う際に必須となる記述
  WidgetsFlutterBinding.ensureInitialized();
  // 端末の向きを縦で固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  /**
   * アプリ初回インストール時の処理
   * - データベースの作成
   * - csvから読み込んだマップリストのinsert
   * - csvから読み込んだ機体リストのinsert
   * - 投票権を所定数付与 付与日の登録
   */
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (_prefs.getBool(SharedPrefKey.DoneFirstProcess.toString()) == null ||
      _prefs.getBool(SharedPrefKey.DoneFirstProcess.toString()) == false) {
    // データベースの作成フラグを確認　未作成であった場合は作成する
    if (_prefs.getBool(SharedPrefKey.MadeDatabase.toString()) == null ||
        _prefs.getBool(SharedPrefKey.MadeDatabase.toString()) == false) {
      MapListRepository mlr = new MapListRepository();
      mlr.init();
    }
    // 初期マップデータを挿入する
    MapListRepository mlr = new MapListRepository();
    mlr.initInsertRecords();
    // 初期機体データを挿入する
    MsListRepository mslr = new MsListRepository();
    mslr.initInsertRecords();
    // MSタイプのデータを挿入する
    MsTypeListRepository mstlr = new MsTypeListRepository();
    mstlr.initInsertRecords();

    // 投票権を所定数付与

    // 処理が成功したか否かに関わらず、初回起動済みフラグはtrueにする
    _prefs.setBool(SharedPrefKey.DoneFirstProcess.toString(), true);
  }
  /**
   * アプリ起動毎の処理
   * - 投票権の付与
   */
  // 投票権を付与数を確認
  CheckVoteRight cvr = new CheckVoteRight();
  int _grantRightNumber = await cvr.isGrantedVoteRight();

  //////デバッグ用のやつ　最終的に消す
  //_prefs.setBool(SharedPrefKey.DoneFirstProcess.toString(), false);
  //////デバッグ用のやつ　最終的に消す
  MsListRepository mslr = new MsListRepository();
  mslr.deleteMyDatabase();

  /**
   * コントローラーを定義する
   */
  // 共通
  Get.put(MobileSuitController(), tag:"mobileSuit");
  // メイン画面
  Get.put(MyBattleRecordAddController(), tag: "myBattleRecordAdd");
  Get.put(AllDataViewController(), tag: "allDataView");
  Get.put(ViewDataFocusOnMapController(), tag: "mapDataView");
  Get.put(ViewDataFocusOnMsController(), tag: "msDataView");
  // パーツ
  Get.put(BattleRecordViewBottomController(), tag: "battleRecordViewBottomNavigation");

  runApp(GetMaterialApp(
    home: MainScreen(),
  ));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;
}

class Home extends StatelessWidget {


  @override
  Widget build(context) {
// 画面サイズを取得しscreen_envへ格納する
    ScreenEnv.deviceWidth = MediaQuery.of(context).size.width;
    ScreenEnv.deviceHeight = MediaQuery.of(context).size.height;
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Get.put(Controller())!;

    return Scaffold(
      // Use Obx(()=> to update Text() whenever count is changed.
      appBar: AppBar(
        title: Obx(() => Text("Clicks: ${c.count}")),
        backgroundColor: Colors.orange,
      ),
      drawer: SafeArea(
        child: Drawer(
          child: DrawerMenu().expansionPanelList(),
        ),
      ),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Center(
          child: TextButton(
        child: Text('Click to show full example'),
        onPressed: () => Navigator.of(context).pushNamed('/bar'),
      )),
      // bottomNavigationBar: ConvexAppBar(
      //   style: TabStyle.react,
      //   items: [
      //     TabItem(icon: Icons.list),
      //     TabItem(icon: Icons.calendar_today),
      //     TabItem(icon: Icons.assessment),
      //   ],
      //   initialActiveIndex: 1,
      //   onTap: (int i) => print('click index=$i'),
      // ),
    );
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}
