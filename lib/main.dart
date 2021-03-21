import 'package:battle_operation2_app/common_widget/drawer_menu.dart';
import 'package:battle_operation2_app/importer/myclass_importer.dart';
import 'package:battle_operation2_app/importer/pub_dev_importer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // main関数内で非同期処理を行う際に必須となる記述
  WidgetsFlutterBinding.ensureInitialized();
  // 端末の向きを縦で固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(GetMaterialApp(home: MainScreen(),));
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

class Controller extends GetxController{
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
            child: new DrawerMenu().expansionPanelList(),
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
  Widget build(context){
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}

